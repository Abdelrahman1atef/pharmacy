import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/checkout/ui/screens/add_location_screen.dart';
import 'package:pharmacy/features/checkout/ui/widgets/toggle_buttons.dart';

import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../logic/toggle_buttons_logic/checkout_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_state.dart';
import '../../ui/widgets/location_bottom_sheet.dart';
import '../../logic/location/location_storage.dart';
import '../../logic/location/saved_location.dart';
import '../../logic/location/location_cubit.dart';
import '../../logic/branch/branch_cubit.dart';
import '../../logic/branch/branch_state.dart';
import '../../../../core/models/branch/branch_response.dart';

class LocationSelectionWidget extends StatefulWidget {
  const LocationSelectionWidget({super.key});

  @override
  State<LocationSelectionWidget> createState() =>
      _LocationSelectionWidgetState();
}

class _LocationSelectionWidgetState extends State<LocationSelectionWidget> {

  @override
  void initState() {
    super.initState();
    // Fetch branches when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BranchCubit>().fetchBranches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DeliveryToggleButtons(),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (context, state) {
                if (state.isHomeDeliverySelected) {
                  return BlocBuilder<LocationCubit, SavedLocation?>(
                    builder: (context, selectedLocation) => _locationSection(
                      context: context,
                      title: S.of(context).location,
                      changeLabel: S.of(context).change,
                      addressWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              Expanded(
                                child: Text(
                                  selectedLocation?.name ?? "اختر موقع التوصيل",
                                  style: TextStyles.orderInfoText.copyWith(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (selectedLocation != null)
                            Text(
                              selectedLocation.street,
                              style: TextStyles.orderInfoText.copyWith(
                                fontSize: 15.sp,
                              ),
                            )
                        ],
                      ),
                      subtitleWidget: const SizedBox(),
                      onChangeTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => LocationBottomSheet(
                            onLocationSelected: (location) {
                              context
                                  .read<LocationCubit>()
                                  .selectLocation(location);
                            },
                            onAddNewLocation: () async {
                              final newLocation = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddLocationScreen(),
                                ),
                              );
                              if (newLocation != null) {
                                List<SavedLocation> locations =
                                    LocationStorage.loadLocations();
                                if (newLocation.isDefault) {
                                  locations = locations
                                      .map((loc) => SavedLocation(
                                            id: loc.id,
                                            name: loc.name,
                                            street: loc.street,
                                            specialPoint: loc.specialPoint,
                                            latitude: loc.latitude,
                                            longitude: loc.longitude,
                                            isDefault: false,
                                          ))
                                      .toList();
                                }
                                locations.add(newLocation);
                                await LocationStorage.saveLocations(locations);
                                // Refresh the default location in cubit
                                context.read<LocationCubit>().refreshDefaultLocation();
                                Navigator.pop(context); // Close bottom sheet
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return BlocBuilder<BranchCubit, BranchState>(
                    builder: (context, branchState) {
                      return _locationSection(
                        context: context,
                        title: S.of(context).pharmacy,
                        changeLabel: S.of(context).change,
                        addressWidget: const SizedBox(),
                        cardWidget: _buildPharmacyCard(context, branchState),
                        onChangeTap: () => _showPharmacySelectionDialog(context, branchState),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _locationSection({
    required BuildContext context,
    required String title,
    required String changeLabel,
    required Widget addressWidget,
    Widget? subtitleWidget,
    Widget? cardWidget,
    VoidCallback? onChangeTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.orderInfoText.copyWith(
                fontSize: 18.sp,
                color: ColorName.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChangeTap != null
                ? GestureDetector(
                    onTap: onChangeTap,
                    child: Text(
                      changeLabel,
                      style: TextStyles.orderInfoText.copyWith(
                        fontSize: 14.sp,
                        color: ColorName.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(
                    changeLabel,
                    style: TextStyles.orderInfoText.copyWith(
                      fontSize: 14.sp,
                      color: ColorName.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
        SizedBox(height: 10.h),
        addressWidget,
        if (subtitleWidget != null) subtitleWidget,
        if (cardWidget != null) ...[
          const SizedBox(height: 10),
          cardWidget,
        ],
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPharmacyContent(BranchState branchState) {
    return branchState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (branches) => _buildPharmacyList(branches),
      selected: (branches, selectedBranch) => _buildSelectedPharmacy(selectedBranch),
      error: (message) => Center(
        child: Text(
          'Error: $message',
          style: TextStyles.orderInfoText.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildPharmacyCard(BuildContext context, BranchState branchState) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildPharmacyContent(branchState),
      ),
    );
  }

  Widget _buildPharmacyList(BranchResponse branches) {
    if (branches.results.isEmpty) {
      return const Center(
        child: Text('No pharmacies available'),
      );
    }

    return Column(
      children: branches.results.map((branch) => ListTile(
        title: Text(branch.branchName),
        subtitle: Text(branch.branchAddress.isNotEmpty ? branch.branchAddress : 'No address'),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          context.read<BranchCubit>().selectBranch(branch);
        },
      )).toList(),
    );
  }

  Widget _buildSelectedPharmacy(Branch branch) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                branch.branchName,
                style: TextStyles.orderInfoText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
        if (branch.branchAddress.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              branch.branchAddress,
              style: TextStyles.orderInfoText.copyWith(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text(S.of(context).openNow)],
        ),
      ],
    );
  }

  void _showPharmacySelectionDialog(BuildContext context, BranchState branchState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Pharmacy',
            style: TextStyles.orderInfoText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: _buildPharmacySelectionContent(branchState),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPharmacySelectionContent(BranchState branchState) {
    return branchState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (branches) => _buildPharmacySelectionList(branches),
      selected: (branches, selectedBranch) => _buildPharmacySelectionList(branches),
      error: (message) => Center(
        child: Text(
          'Error: $message',
          style: TextStyles.orderInfoText.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildPharmacySelectionList(BranchResponse branches) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: branches.results.length,
      itemBuilder: (context, index) {
        final branch = branches.results[index];
        return ListTile(
          title: Text(branch.branchName),
          subtitle: Text(branch.branchAddress.isNotEmpty ? branch.branchAddress : 'No address'),
          onTap: () {
            context.read<BranchCubit>().selectBranch(branch);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
