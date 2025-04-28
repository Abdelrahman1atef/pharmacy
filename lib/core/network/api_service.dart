import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pharmacy/core/models/category/category_response.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/models/search/search_response.dart';
import 'package:pharmacy/core/network/constant.dart';
import '../models/register_login/login_request.dart';
import '../models/register_login/register_request.dart';
import 'api_exception.dart';
import 'api_result.dart';

abstract class ApiService {
  Future<ApiResult<ProductResponse>> fetchAllProduct(int page);
  Future<ApiResult<Results>> fetchProductDetails(int productId);
  Future<ApiResult<ProductResponse>> fetchProductByCategory({required int categoryId, required int page});
  Future<ApiResult<List<CategoryResponse>>> fetchAllCategory();
  Future<ApiResult<List<SearchResponse>>> searchProduct(String query);
  Future<ApiResult<RegisterRequest>>userRegister(RegisterRequest register);
  Future<ApiResult<LoginRequest>>userLogin();
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
  Future<ApiResult<ProductResponse>> fetchProductByCategory({required int categoryId, required int page}) async {
    try {
      Response response = await _dio.get(
          '${Constant.allProductsOfCategoriesEndPoint}$categoryId',
          queryParameters: {'page': page});
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

  @override
  Future<ApiResult<RegisterRequest>> userRegister(RegisterRequest registerBody) async{
    try {
      // Converting the object to a Map
      final registerRequestBody = registerBody.toJson();

// Encoding the map to a JSON string
      final jsonBody = json.encode(registerRequestBody);
      // Make the POST request with the registerJson as the body
      Response response = await _dio.post(
        Constant.register, // Replace with your actual endpoint
        data: jsonBody, // Pass the JSON data as the body
      );

      // Assuming response.data is the response JSON from the server
      // Here you can map the response data back to RegisterRequest object if needed
      if (response.statusCode == 201) {
        // If the request is successful, return the response
        return ApiResult<RegisterRequest>.success(RegisterRequest.fromJson(response.data));
      } else {
        // Handle any other status code (e.g., 400, 500)
        return ApiResult<RegisterRequest>.failure(ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<RegisterRequest>.failure(ApiException(
          message: e.message ?? "Unable to Register New User",
          code: e.response?.statusCode ?? 0));
    }
  }
  @override
  Future<ApiResult<LoginRequest>> userLogin() {
    // TODO: implement userRegister
    throw UnimplementedError();
  }
}















