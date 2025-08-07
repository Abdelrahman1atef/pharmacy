// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchResponse _$BranchResponseFromJson(Map<String, dynamic> json) =>
    BranchResponse(
      count: (json['count'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchResponseToJson(BranchResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      branchId: (json['branch_id'] as num).toInt(),
      branchCode: json['branch_code'] as String,
      branchName: json['branch_name'] as String,
      branchAddress: json['branch_address'] as String,
      branchTel: json['branch_tel'] as String,
      branchMobile: json['branch_mobile'] as String,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_code': instance.branchCode,
      'branch_name': instance.branchName,
      'branch_address': instance.branchAddress,
      'branch_tel': instance.branchTel,
      'branch_mobile': instance.branchMobile,
    };
