import 'package:bloc/bloc.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/features/home/repository/best_seller/best_seller_repository.dart';

import 'best_seller_state.dart';


class BestSellerCubit extends Cubit<BestSellerState> {
  final BestSellerRepository _bestSellerRepository;
  BestSellerCubit(this._bestSellerRepository) : super(const Initial());

  void emitBestSellerState() {
    emit(const Loading());
    _bestSellerRepository.fetchBestSellers(page: 1).then((result) {
      result.when(
          success: (ProductResponse data) => emit(Success(data)),
          failure: (error) => emit(Error(error)));
    });
  }
}
