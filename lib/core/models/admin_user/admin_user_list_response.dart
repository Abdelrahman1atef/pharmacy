import 'package:json_annotation/json_annotation.dart';

part 'admin_user_list_response.g.dart';

@JsonSerializable()
class AdminUser {
  final int id;
  final String email;
  final String phone;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String? birthdate;
  final String? gender;
  @JsonKey(name: 'auth_type')
  final String authType;
  @JsonKey(name: 'social_id')
  final String? socialId;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_staff')
  final bool isStaff;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'last_login')
  final String? lastLogin;
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @JsonKey(name: 'total_spent')
  final double totalSpent;
  @JsonKey(name: 'avg_order_value')
  final double avgOrderValue;
  @JsonKey(name: 'last_order_date')
  final String? lastOrderDate;
  @JsonKey(name: 'first_order_date')
  final String? firstOrderDate;
  @JsonKey(name: 'order_status_distribution')
  final Map<String, int> orderStatusDistribution;

  AdminUser({
    required this.id,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.birthdate,
    required this.gender,
    required this.authType,
    this.socialId,
    required this.profilePicture,
    required this.isActive,
    required this.isStaff,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
    required this.totalOrders,
    required this.totalSpent,
    required this.avgOrderValue,
    this.lastOrderDate,
    this.firstOrderDate,
    required this.orderStatusDistribution,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) => _$AdminUserFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUserToJson(this);
}

@JsonSerializable()
class AdminUserListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<AdminUser> results;

  AdminUserListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory AdminUserListResponse.fromJson(Map<String, dynamic> json) => _$AdminUserListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUserListResponseToJson(this);
} 