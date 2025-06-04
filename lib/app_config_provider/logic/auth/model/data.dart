import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data  {
  final int id;
  final String email;
  final String phone;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final String? birthdate;
  final String gender;
  final String? password;
  @JsonKey(name: "profile_picture")
  final String? profilePicture;
  @JsonKey(name: "is_active")
  final bool isActive;
  @JsonKey(name: "is_staff")
  final bool isStaff;

  Data(
      {
        required this.id,
        required this.email,
        required this.phone,
        required this.firstName,
        required this.lastName,
        required this.birthdate,
        required this.gender,
        required this.password,
        required this.profilePicture,
        required this.isActive,
        required this.isStaff});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String,dynamic> toJson()=>_$DataToJson(this);
}
