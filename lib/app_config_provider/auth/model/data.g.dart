// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      email: json['email'] as String,
      phone: json['phone'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      birthdate: json['birthdate'] as String?,
      gender: json['gender'] as String,
      password: json['password'] as String?,
      profilePicture: json['profile_picture'] as String?,
      isActive: json['is_active'] as bool,
      isStaff: json['is_staff'] as bool,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'password': instance.password,
      'profile_picture': instance.profilePicture,
      'is_active': instance.isActive,
      'is_staff': instance.isStaff,
    };
