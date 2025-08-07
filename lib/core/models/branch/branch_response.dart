import 'package:json_annotation/json_annotation.dart';

part 'branch_response.g.dart';

@JsonSerializable()
class BranchResponse {
  final int count;
  final List<Branch> results;

  BranchResponse({
    required this.count,
    required this.results,
  });

  factory BranchResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BranchResponseToJson(this);
}

@JsonSerializable()
class Branch {
  @JsonKey(name: 'branch_id')
  final int branchId;
  
  @JsonKey(name: 'branch_code')
  final String branchCode;
  
  @JsonKey(name: 'branch_name')
  final String branchName;
  
  @JsonKey(name: 'branch_address')
  final String branchAddress;
  
  @JsonKey(name: 'branch_tel')
  final String branchTel;
  
  @JsonKey(name: 'branch_mobile')
  final String branchMobile;

  Branch({
    required this.branchId,
    required this.branchCode,
    required this.branchName,
    required this.branchAddress,
    required this.branchTel,
    required this.branchMobile,
  });

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
} 