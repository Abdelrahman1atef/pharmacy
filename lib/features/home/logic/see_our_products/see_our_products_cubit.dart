import 'package:bloc/bloc.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/features/home/repository/see_our_products/see_our_products_repository.dart';

import 'see_our_products_state.dart';


class SeeOurProductsCubit extends Cubit<SeeOurProductsState> {
  final SeeOurProductsRepository _seeOurProductsRepository;
  SeeOurProductsCubit(this._seeOurProductsRepository) : super(const Initial());

  void emitSeeOurProductsState() {
    emit(const Loading());
    _seeOurProductsRepository.fetchSeeOurProducts(page: 1).then((result) {
      result.when(
          success: (ProductResponse data) => emit(Success(data)),
          failure: (error) => emit(Error(error)));
    });
  }
} 