import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/routes/routes.dart';
import '../../cart/logic/cart/cart_cubit.dart';
import '../logic/details/details_cubit.dart';
import '../logic/details/details_state.dart' as details_state;
import 'widgets/detail_loading_widget.dart';
import 'widgets/product_action_bar.dart';
import 'widgets/product_details_section.dart';
import 'widgets/product_image_section.dart';
import 'widgets/product_info_section.dart';

class DetailScreen extends StatelessWidget {
  final int productId;

  const DetailScreen(this.productId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DetailsCubit>().emitDetailsState(productId);
    context.read<CartCubit>().emitCartState();
    return Scaffold(
      appBar: PharmacyAppBar(
        onSearchTap: () => Navigator.pushNamed(context, Routes.searchScreen),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<DetailsCubit, details_state.DetailsState>(
          builder: (context, state) {
            if (state is details_state.Loading) {
              return const DetailLoadingWidget();
            } else if (state is details_state.Error) {
              return Center(
                child: Text(
                  'Error: ${state.e}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is details_state.Success) {
              final product = state.data as Results;
              return _buildProductDetailScreen(context, product);
            }
            return const Text("data");
          },
        ),
      ),
    );
  }

  Widget _buildProductDetailScreen(BuildContext context, Results product) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product image section
            ProductImageSection(product: product),

            SizedBox(height: 8.h),

            // Product info section (name, availability, unit toggle, price)
            ProductInfoSection(product: product),

            SizedBox(height: 8.h),

            // Product details section (brand, unit, description)
            ProductDetailsSection(product: product),

            SizedBox(height: 15.h),
            SizedBox(height: 30.h),
          ],
        ),
      ),
      bottomNavigationBar: ProductActionBar(product: product),
    );
  }
}
