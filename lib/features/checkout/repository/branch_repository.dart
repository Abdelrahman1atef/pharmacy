import 'package:pharmacy/core/models/branch/branch_response.dart';
import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_exception.dart';

class BranchRepository {
  final ApiService _apiService;

  BranchRepository(this._apiService);

  Future<ApiResult<BranchResponse>> getBranches() async {
    try {
      final response = await _apiService.getBranches();
      return response;
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to fetch branches: $e',
        code: 500,
      ));
    }
  }
} 