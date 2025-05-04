import '../../../app_config_provider/auth/model/data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';
@JsonSerializable()
class LoginResponse {
  final String token;
  final Data user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>_$LoginResponseFromJson(json);
}
