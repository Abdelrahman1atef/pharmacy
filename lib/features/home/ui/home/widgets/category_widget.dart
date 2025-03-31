import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/home/logic/category/category_cubit.dart';
import 'package:pharmacy/features/home/logic/category/category_state.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/utils/device_size.dart';

import '../../../../../core/common_widgets/header_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/network_image_utils.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Column(
            children: [
              HeaderWidget(
                widgetTitle: S.of(context).titles_category,
                showAllIsVisible: false,
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                width: double.infinity,
                height: deviceSize.height * 0.25,
                child: BlocBuilder<CategoryCubit, CategoryState>(
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
                    } else if (state is Success) {
                      final categories = state.data;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = categories[index];
                          return Card(
                            elevation: 5,
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                 SizedBox(
                                   height: 30,
                                   width: 20,
                                   child: Image.network(
                                     "URL",
                                    fit: BoxFit.cover,
                                     loadingBuilder: loadingBuilder(),
                                     errorBuilder: (context, error, stackTrace) => Assets.images.categoryDefaultIcon.svg(),
                                                                     ),
                                 ),
                              // Display product name
                              Text(
                                category.categoryNameAr,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          );


                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
