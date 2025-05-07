import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../logic/search_cubit.dart';


class SearchWidget extends StatefulWidget {
  final bool enabled;
  final VoidCallback? onTap;
  final TextEditingController? searchController;

  const SearchWidget(
      {super.key, required this.enabled, this.onTap, this.searchController});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late final Debouncer<String> _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer<String>(
      const Duration(milliseconds: 500),
      initialValue: '',
      checkEquality: false,
      onChanged: (query) {
        context.read<SearchCubit>().emitSearchState(query); // Trigger search logic
      },
    );

    widget.searchController?.addListener(() {
      _debouncer.setValue(widget.searchController!.text); // Update debouncer
    });
  }

  @override
  void dispose() {
    _debouncer.cancel(); // Clean up the debouncer
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        height: 45.h,
        child: SearchBar(
          controller:widget.searchController,
          autoFocus: true,
          trailing:  const [
            Icon(Icons.search, color: Colors.grey)
          ],
          hintStyle: const WidgetStatePropertyAll(
              TextStyle(color: Colors.grey)),
          hintText: S.of(context).search_for_medicine,
          enabled: widget.enabled, // Enable or disable interaction
        ),
      ),
    );
  }
}
