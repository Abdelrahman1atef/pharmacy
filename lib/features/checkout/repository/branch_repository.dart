import 'package:pharmacy/core/models/branch/branch_response.dart';
import 'package:pharmacy/core/network/api_client.dart';
import 'package:pharmacy/core/network/api_result.dart';

class BranchRepository {
  final ApiClient _apiClient;

  BranchRepository(this._apiClient);

  Future<ApiResult<BranchResponse>> getBranches() async {
    try {
      final response = await _apiClient.get('/api/branches');
      final branchResponse = BranchResponse.fromJson(response.data);
      return ApiResult.success(branchResponse);
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to fetch branches: $e',
        statusCode: 500,
      ));
    }
  }
} 