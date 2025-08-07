import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch_response.g.dart';

@freezed
class BranchResponse with _$BranchResponse {
  const factory BranchResponse({
    required int id,
    required String name,
    required String address,
    required String phone,
    required bool isOpen,
    required double latitude,
    required double longitude,
    String? workingHours,
    String? description,
  }) = _BranchResponse;

  factory BranchResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchResponseFromJson(json);
}

@freezed
class BranchListResponse with _$BranchListResponse {
  const factory BranchListResponse({
    required List<BranchResponse> branches,
    required int total,
    required int page,
    required int limit,
  }) = _BranchListResponse;

  factory BranchListResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchListResponseFromJson(json);
} 