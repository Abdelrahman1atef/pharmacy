import 'package:json_annotation/json_annotation.dart';


part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String message;
  final String email;
  RegisterResponse({
    required this.message,
    required this.email,
  });
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
