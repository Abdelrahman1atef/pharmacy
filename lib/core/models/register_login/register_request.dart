import 'package:json_annotation/json_annotation.dart';


part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String phone;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final String? birthdate;
  final String gender;
  final String password;
  @JsonKey(name: "profile_picture")
  final String? profilePicture;
  final bool isActive;
  final bool isStaff;

  RegisterRequest({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.gender,
    required this.password,
    required this.profilePicture,
    required this.isActive,
    required this.isStaff,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
