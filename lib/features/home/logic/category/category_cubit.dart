
import 'package:pharmacy/core/db/cache/cached_cubit_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';
import 'package:pharmacy/core/models/category/category_response.dart';
import 'package:pharmacy/features/home/repository/category/category_repository.dart';

import 'category_state.dart';

class CategoryCubit extends CachedCubitBase<CategoryState> {
  final CategoryRepository _categoryRepository;
  
  CategoryCubit(this._categoryRepository) : super(const Initial());

  void emitCategoryState() {
    emit(const Loading());
    
    loadCachedData<CategoryResponse>(
      cacheKey: categoriesCacheKey,
      apiCall: () => _categoryRepository.fetchAllCategory(),
      onSuccess: (CategoryResponse data) => emit(Success(data)),
      onError: (error) => emit(Error(error)),
    );
  }

  /// Clear category cache and refresh
  Future<void> refreshCategories() async {
    await clearCache(categoriesCacheKey);
    emitCategoryState();
  }
}
