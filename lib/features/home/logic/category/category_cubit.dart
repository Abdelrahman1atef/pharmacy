
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/models/category/category_response.dart';
import 'package:pharmacy/features/home/repository/category/category_repository.dart';

import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryCubit(this._categoryRepository) : super(const Initial());

  void emitCategoryState() {
    emit(const Loading());
    _categoryRepository.fetchAllCategory().then((result) {
      result.when(
          success: (List<CategoryResponse> data) => emit(Success(data)),
          failure: (error) => emit(Error(error)));
    });
  }
}
