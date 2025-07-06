// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUser _$AdminUserFromJson(Map<String, dynamic> json) => AdminUser(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      phone: json['phone'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      fullName: json['full_name'] as String,
      birthdate: json['birthdate'] as String,
      gender: json['gender'] as String,
      authType: json['auth_type'] as String,
      socialId: json['social_id'] as String?,
      profilePicture: json['profile_picture'] as String,
      isActive: json['is_active'] as bool,
      isStaff: json['is_staff'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      lastLogin: json['last_login'] as String,
      totalOrders: (json['total_orders'] as num).toInt(),
      totalSpent: (json['total_spent'] as num).toDouble(),
      avgOrderValue: (json['avg_order_value'] as num).toDouble(),
      lastOrderDate: json['last_order_date'] as String?,
      firstOrderDate: json['first_order_date'] as String?,
      orderStatusDistribution:
          Map<String, int>.from(json['order_status_distribution'] as Map),
    );

Map<String, dynamic> _$AdminUserToJson(AdminUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'full_name': instance.fullName,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'auth_type': instance.authType,
      'social_id': instance.socialId,
      'profile_picture': instance.profilePicture,
      'is_active': instance.isActive,
      'is_staff': instance.isStaff,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'last_login': instance.lastLogin,
      'total_orders': instance.totalOrders,
      'total_spent': instance.totalSpent,
      'avg_order_value': instance.avgOrderValue,
      'last_order_date': instance.lastOrderDate,
      'first_order_date': instance.firstOrderDate,
      'order_status_distribution': instance.orderStatusDistribution,
    };

AdminUserListResponse _$AdminUserListResponseFromJson(
        Map<String, dynamic> json) =>
    AdminUserListResponse(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => AdminUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminUserListResponseToJson(
        AdminUserListResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
