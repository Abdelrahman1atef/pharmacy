import 'package:bloc/bloc.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/features/details/repository/details_repository.dart';

import 'details_state.dart';


class DetailsCubit extends Cubit<DetailsState> {
  final DetailsRepository _detailsRepository;
  DetailsCubit(this._detailsRepository) : super(const Initial());

  void emitDetailsState(int productId) {
    emit(const Loading());
    _detailsRepository.getProductDetails(productId).then((result) {
      result.when(
          success: (Results data) => emit(Success(data)),
          failure: (error) => emit(Error(error)));
    });
  }
}
