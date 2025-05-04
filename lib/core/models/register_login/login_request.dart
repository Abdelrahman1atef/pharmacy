import 'package:json_annotation/json_annotation.dart';
part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String? email;
  final String? phone;
  final String password;

  LoginRequest({this.email, this.phone, required this.password});

 Map<String,dynamic> toJson()=>_$LoginRequestToJson(this);
}


