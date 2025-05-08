import 'package:json_annotation/json_annotation.dart';

import '../../../app_config_provider/logic/auth/model/data.dart';
part 'login_response.g.dart';
@JsonSerializable()
class LoginResponse {
  final String token;
  final Data user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>_$LoginResponseFromJson(json);
}
