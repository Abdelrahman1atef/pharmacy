import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/di/module.dart';
import 'package:pharmacy/core/routes/routes.dart';

import '../../../../generated/l10n.dart';
import '../../logic/search_cubit.dart';
import '../../logic/search_state.dart';



class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => getIt<SearchCubit>()..emitSearchState(''),
      child: _SearchScreenState(),
    );
  }
}

class _SearchScreenState extends StatefulWidget {
  @override
  __SearchScreenStateState createState() => __SearchScreenStateState();
}

class __SearchScreenStateState extends State<_SearchScreenState> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            PharmacyAppBar(
              searchEnabled: true,
              searchController: _searchController, // Pass the shared controller
            ),
            Expanded(child: _SearchResults()),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
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
          final products = state.data;
          if (products.isEmpty) {
            return const Center(
              child: Text(
                "مفيش منتج بالاسم دا",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: ListView.separated(
              itemCount: products.length,
              separatorBuilder: (BuildContext context, int index)=>const Divider(
                color: Colors.grey, // Customize the divider color
                thickness: 1,       // Customize the thickness of the line
                height: 1,          // Space around the divider
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap: () => Navigator.pushNamed(context,Routes.productDetail,arguments: product.productId),
                  child: ListTile(
                    leading: Text(product.productId.toString()),
                    title: Text(product.productNameAr ?? '',maxLines: 1,overflow: TextOverflow.ellipsis,),
                    subtitle: Text(product.productNameEn,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    trailing: SizedBox(
                      width: 100,
                      child: Text(
                        '${S.of(context).pound} ${product.sellPrice}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }

        // Throw an assertion error for unknown states
        assert(false, 'Unknown state: $state');
        return const SizedBox.shrink();
      },
    );
  }
}
