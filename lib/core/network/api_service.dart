import 'package:dio/dio.dart';
import 'package:pharmacy/core/models/category_response.dart';
import 'package:pharmacy/core/models/product_response.dart';
import 'package:pharmacy/core/models/search_response.dart';
import 'package:pharmacy/core/network/constant.dart';
import 'api_exception.dart';
import 'api_result.dart';

abstract class ApiService {
  Future<ApiResult<ProductResponse>> fetchAllProduct(int page);

  Future<ApiResult<Results>> fetchProductDetails(int productId);

  Future<ApiResult<ProductResponse>> fetchProductByCategory(int categoryId);

  Future<ApiResult<List<CategoryResponse>>> fetchAllCategory();

  Future<ApiResult<List<SearchResponse>>> searchProduct(String query);
}

class ApiServiceImpl implements ApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<ApiResult<ProductResponse>> fetchAllProduct(int page) async {
    try {
      Response response = await _dio
          .get(Constant.allProductsEndPoint, queryParameters: {'page': page});
      if (response.statusCode == 200) {
        return ApiResult<ProductResponse>.success(
            ProductResponse.formJson(response.data));
      } else {
        return ApiResult<ProductResponse>.failure(
            ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<ProductResponse>.failure(ApiException(
          message: e.message ?? "Unable to fetch Now Showing Movies",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<List<CategoryResponse>>> fetchAllCategory() async {
    try {
      Response response = await _dio.get(Constant.allCategoriesEndPoint);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        final List<CategoryResponse> categoryResults =
            CategoryResponse.fromJsonList(data);
        return ApiResult<List<CategoryResponse>>.success(categoryResults);
      } else {
        throw ApiException.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print("Dio Error: ${e.message}");
      } else {
        print("Unexpected Error: $e");
      }
      rethrow;
    }
  }

  @override
  Future<ApiResult<ProductResponse>> fetchProductByCategory(int categoryId) {
    // TODO: implement fetchProductByCategory
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<Results>> fetchProductDetails(int productId) async {
    try {
      Response response =
          await _dio.get('${Constant.productDetailsEndPoint}$productId');
      if (response.statusCode == 200) {
        return ApiResult<Results>.success(Results.fromJson(response.data));
      } else {
        return ApiResult<Results>.failure(ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<Results>.failure(ApiException(
          message: e.message ?? "Unable to fetch Now Showing Movies",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<List<SearchResponse>>> searchProduct(String query) async {
    try {
      Response response = await _dio
          .get(Constant.searchEndPoint, queryParameters: {'q': query});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        final List<SearchResponse> searchResults =
            SearchResponse.fromJsonList(data);
        return ApiResult<List<SearchResponse>>.success(searchResults);
      } else {
        throw ApiException.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print("Dio Error: ${e.message}");
      } else {
        print("Unexpected Error: $e");
      }
      rethrow;
    }
  }
}
