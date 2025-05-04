import 'package:json_annotation/json_annotation.dart';
import 'package:pharmacy/app_config_provider/auth/model/data.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest extends Data {
  RegisterRequest(
      {required super.email,
      required super.phone,
      required super.firstName,
      required super.lastName,
      required super.birthdate,
      required super.gender,
      required super.password,
      required super.profilePicture,
      required super.isActive,
      required super.isStaff});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
