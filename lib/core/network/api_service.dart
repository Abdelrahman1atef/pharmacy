import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pharmacy/core/models/category/category_response.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/models/register_login/login_response.dart';
import 'package:pharmacy/core/models/search/search_response.dart';
import 'package:pharmacy/core/network/constant.dart';
import '../../app_config_provider/logic/auth/model/data.dart';
import '../models/register_login/login_request.dart';
import '../models/register_login/register_request.dart';
import 'api_exception.dart';
import 'api_result.dart';

abstract class ApiService {
  Future<bool> checkServerStatus();
  Future<ApiResult<ProductResponse>> fetchAllProduct(int page);

  Future<ApiResult<Results>> fetchProductDetails(int productId);

  Future<ApiResult<ProductResponse>> fetchProductByCategory(
      {required int categoryId, required int page});

  Future<ApiResult<List<CategoryResponse>>> fetchAllCategory();

  Future<ApiResult<List<SearchResponse>>> searchProduct(String query);

  Future<ApiResult<RegisterRequest>> userRegister(RegisterRequest registerBody);

  Future<ApiResult<LoginResponse>> userLogin(LoginRequest loginBody);

  Future<ApiResult<Data>> getProfile(token);
}

class ApiServiceImpl implements ApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<bool> checkServerStatus() async {
    try{
      Response response =await _dio.get(Constant.apiHealth);
      if(response.statusCode==200){
        return true;
      }else{
       return false;
      }
    }on DioException{
      return false;
    }
  }
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
  Future<ApiResult<RegisterRequest>> userRegister(RegisterRequest registerBody) async {
    try {
      final registerRequestBody = registerBody.toJson();

      final jsonBody = json.encode(registerRequestBody);
      Response response = await _dio.post(
        Constant.register,
        data: jsonBody,
      );

      if (response.statusCode == 201) {
        return ApiResult<RegisterRequest>.success(
            RegisterRequest.fromJson(response.data));
      } else {
        return ApiResult<RegisterRequest>.failure(
            ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<RegisterRequest>.failure(ApiException(
          message: e.message ?? "Unable to Register New User",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<LoginResponse>> userLogin(LoginRequest loginBody) async {
    try {
      final registerRequestBody = loginBody.toJson();

      final jsonBody = json.encode(registerRequestBody);
      Response response = await _dio.post(
        Constant.login,
        data: jsonBody,
      );
      if (response.statusCode == 200) {
        return ApiResult<LoginResponse>.success(LoginResponse.fromJson(response.data));
      } else {
        return ApiResult<LoginResponse>.failure(ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<LoginResponse>.failure(ApiException(
          message: e.message ?? "Unable to Login User",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<Data>> getProfile(token) async {
    try {
      Response response = await _dio.get(Constant.userInfoEndPoint,
          options: Options(
            headers: {
              "Authorization": "Token $token",
              "Accept": "application/json"
            },
          ));
      if (response.statusCode == 200) {
        return ApiResult<Data>.success(Data.fromJson(response.data));
      } else {
        return ApiResult<RegisterRequest>.failure(
            ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<RegisterRequest>.failure(ApiException(
          message: e.message ?? "Unable to Get User Info",
          code: e.response?.statusCode ?? 0));
    }
  }
}
