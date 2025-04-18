import 'package:freezed_annotation/freezed_annotation.dart';
part 'db_result.freezed.dart';
@freezed
class DBResult<T> with _$DBResult<T>{
  factory DBResult.success(T data) = _Success<T>;
  factory DBResult.failure(String e) = _Failure<T>;
}