import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/features/details/logic/details_cubit.dart';
import 'package:pharmacy/features/details/logic/details_state.dart';
import 'package:pharmacy/utils/device_size.dart';
import '../../../core/di/module.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/network_image_utils.dart';
import '../../search/logic/search_cubit.dart';

class DetailScreen extends StatelessWidget {
  final int productId;

  const DetailScreen(this.productId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>(
      create: (context) =>
      getIt<DetailsCubit>()
        ..emitDetailsState(productId),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Error) {
                return Center(
                  child: Text(
                    'Error: ${state.e}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }else if (state is Success){
                final product = state.data;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: DeviceSize(context).height*0.4,
                      pinned: true,
                      floating: true,
                      iconTheme: const IconThemeData(color: Colors.white,),
                      flexibleSpace: FlexibleSpaceBar(
                        background: GestureDetector(
                          child:product.productImageUrl==null?Image.asset(Assets.images.drug.path): Image.network(
                              'URL',
                              fit: BoxFit.cover,
                              loadingBuilder: loadingBuilder(),
                              errorBuilder: errorBuilder()
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsetsDirectional.all(24.r),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate([
                              ElevatedButton(onPressed:  () {
                                
                              }, child: Text("Add to cart"))
                          ])),
                    ),
                  ],
                );
              }
              return Text("data");
            },
          ),
        ),
      ),
    );
  }
}