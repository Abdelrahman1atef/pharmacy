import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pharmacy/core/models/category/category_response.dart';
import 'package:pharmacy/core/models/order/create/order_request.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/models/register_login/login_response.dart';
import 'package:pharmacy/core/models/search/search_response.dart';
import 'package:pharmacy/core/models/admin_user/admin_user_list_response.dart';
import 'package:pharmacy/core/models/admin_user/admin_user_detail_response.dart';
import 'package:pharmacy/core/network/constant.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';
import '../../app_config_provider/logic/auth/model/data.dart';
import '../enum/order_status.dart';
import '../models/order/admin/admin_order_model.dart';
import '../models/order/create/order_response.dart';
import '../models/order/customer/customer_order_model.dart';
import '../models/register_login/login_request.dart';
import '../models/register_login/register_request.dart';
import 'api_exception.dart';
import 'api_result.dart';

abstract class ApiService {
  Future<bool> checkServerStatus();

  Future<ApiResult<ProductResponse>> fetchAllProduct(int page);

  Future<ApiResult<ProductResponse>> fetchBestSellers(int page);

  Future<ApiResult<ProductResponse>> fetchSeeOurProducts(int page);

  Future<ApiResult<Results>> fetchProductDetails(int productId);

  Future<ApiResult<ProductResponse>> fetchProductByCategory(
      {required int categoryId, required int page});

  Future<ApiResult<List<CategoryResponse>>> fetchAllCategory();

  Future<ApiResult<List<SearchResponse>>> searchProduct(String query);

  Future<ApiResult<RegisterRequest>> userRegister(RegisterRequest registerBody);

  Future<ApiResult<LoginResponse>> userLogin(LoginRequest loginBody);

  Future<ApiResult<Data>> getProfile(token);

  Future<ApiResult<OrderResponse>> createOrder(OrderRequest orderBody, token);

  Future<ApiResult<List<AdminOrderModel>>> getAdminOrders(token);

  Future<void> updateOrderStatus(
      int orderId, OrderStatus newStatus, token);

  Future<ApiResult<List<CustomerOrderModel>>> getCustomerOrders(token);

  Future<ApiResult<AdminUserListResponse>> fetchAdminUsers({String? search, required int page,required token});
  Future<ApiResult<AdminUserDetailResponse>> fetchAdminUserDetail(int userId,{required token});

  Future<ApiResult<DashboardResponse>> fetchAdminDashboard({required String token});

  Future<void> sendFCMToken(String fcmToken, String userToken);
}

class ApiServiceImpl implements ApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<bool> checkServerStatus() async {
    try {
      Response response = await _dio.get(Constant.apiHealth,options:Options(
        headers: {
          'Accept': 'application/json'
        }
      ) );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException {
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
  Future<ApiResult<ProductResponse>> fetchBestSellers(int page) async {
    try {
      Response response = await _dio
          .get(Constant.bestSellersEndPoint, queryParameters: {'page': page});
      if (response.statusCode == 200) {
        return ApiResult<ProductResponse>.success(
            ProductResponse.formJson(response.data));
      } else {
        return ApiResult<ProductResponse>.failure(
            ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<ProductResponse>.failure(ApiException(
          message: e.message ?? "Unable to fetch Best Sellers",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<ProductResponse>> fetchSeeOurProducts(int page) async {
    try {
      Response response = await _dio
          .get(Constant.seeOurProductsEndPoint, queryParameters: {'page': page});
      if (response.statusCode == 200) {
        return ApiResult<ProductResponse>.success(
            ProductResponse.formJson(response.data));
      } else {
        return ApiResult<ProductResponse>.failure(
            ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<ProductResponse>.failure(ApiException(
          message: e.message ?? "Unable to fetch See Our Products",
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
  Future<ApiResult<ProductResponse>> fetchProductByCategory(
      {required int categoryId, required int page}) async {
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
  Future<ApiResult<RegisterRequest>> userRegister(
      RegisterRequest registerBody) async {
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
      final loginRequestBody = loginBody.toJson();

      final jsonBody = json.encode(loginRequestBody);
      Response response = await _dio.post(
        Constant.login,
        data: jsonBody,
      );
      if (response.statusCode == 200) {
        return ApiResult<LoginResponse>.success(
            LoginResponse.fromJson(response.data));
      } else {
        return ApiResult<LoginResponse>.failure(
            ApiException.fromJson(response.data));
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
        return ApiResult<Data>.failure(ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<Data>.failure(ApiException(
          message: e.message ?? "Unable to Get User Info",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<OrderResponse>> createOrder(
      OrderRequest orderBody, token) async {
    final jsonBody = json.encode(orderBody.toJson());
    Response response = await _dio.post(Constant.createOrder,
        data: jsonBody,
        options: Options(
          headers: {
            "Authorization": "Token $token",
            "Accept": "application/json"
          },
        ));
    if (response.statusCode == 201) {
      return ApiResult.success(OrderResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(ApiException.fromJson(response.data));
    }
  }

  @override
  Future<ApiResult<List<AdminOrderModel>>> getAdminOrders(token) async {
    try {
      Response response = await _dio.get(Constant.adminOrdersEndPoint,
          options: Options(
            headers: {
              "Authorization": "Token $token",
              "Accept": "application/json"
            },
          ));
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final orders = data.map((e) => AdminOrderModel.fromJson(e)).toList();
        return ApiResult<List<AdminOrderModel>>.success(orders);
      } else {
        return ApiResult<List<AdminOrderModel>>.failure(
            ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<List<AdminOrderModel>>.failure(ApiException(
          message: e.message ?? "Unable to Get User Info",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<List<CustomerOrderModel>>> getCustomerOrders(token) async {
    try {
      Response response = await _dio.get(Constant.customerOrdersEndPoint,
          options: Options(
            headers: {
              "Authorization": "Token $token",
              "Accept": "application/json"
            },
          ));
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final orders = data.map((e) => CustomerOrderModel.fromJson(e)).toList();
        return ApiResult<List<CustomerOrderModel>>.success(orders);
      } else {
        return ApiResult<List<CustomerOrderModel>>.failure(
            ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult<List<CustomerOrderModel>>.failure(ApiException(
          message: e.message ?? "Unable to Get User Info",
          code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<void> updateOrderStatus(
      int orderId, OrderStatus newStatus, token) async {
     await _dio.patch(
      "${Constant.adminChangeOrderStatusEndPoint}$orderId/",
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        },
      ),
      data: jsonEncode({
        'status': newStatus.name,
      }),
    );
  }

  @override
  Future<ApiResult<AdminUserListResponse>> fetchAdminUsers({String? search, required int page,required token}) async {
    try {
      final params = <String, dynamic>{'page': page};
      if (search != null && search.isNotEmpty) {
        params['search'] = search;
      }
      final response = await _dio.get(
        Constant.adminUsersEndPoint,
        queryParameters: params,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return ApiResult.success(AdminUserListResponse.fromJson(response.data));
      } else {
        return ApiResult.failure(ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult.failure(ApiException(message: e.message ?? 'Unknown error', code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<AdminUserDetailResponse>> fetchAdminUserDetail(int userId,
      {required token}) async {
    try {
      final response = await _dio.get('${Constant.adminUserDetailEndPoint}$userId/',
        options: Options(
        headers: {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        },
      ),);
      if (response.statusCode == 200) {
        return ApiResult.success(AdminUserDetailResponse.fromJson(response.data));
      } else {
        return ApiResult.failure(ApiException.fromJson(response.data));
      }
    } on DioException catch (e) {
      return ApiResult.failure(ApiException(message: e.message ?? 'Unknown error', code: e.response?.statusCode ?? 0));
    }
  }

  @override
  Future<ApiResult<DashboardResponse>> fetchAdminDashboard({required String token}) async {
    final response = await _dio.get(
      Constant.adminDashboardEndPoint,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        },
      ),
    );
    if (response.statusCode == 200) {
      return ApiResult.success(DashboardResponse.fromJson(response.data));
    } else {
      throw ApiException.fromJson(response.data);
    }
  }

  @override
  Future<void> sendFCMToken(String fcmToken, String userToken) async {
    try {
      await _dio.post(
        Constant.fcmToken,
        data: {'token': fcmToken},
        options: Options(
            headers: {
              'Authorization': 'Token $userToken'
            }
        ),
      );
    } catch (e) {
      // Optionally handle/log error
      rethrow;
    }
  }
}
