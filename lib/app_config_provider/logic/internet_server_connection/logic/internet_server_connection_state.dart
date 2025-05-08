import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_server_connection_state.freezed.dart';

@freezed
class InternetServerConnectionState with _$InternetServerConnectionState {
  const factory InternetServerConnectionState.initial() = Initial;
  const factory InternetServerConnectionState.loading() = Loading;
  const factory InternetServerConnectionState.deviceIsConnected(String message) = DeviceIsConnected;
  const factory InternetServerConnectionState.serverIsWork() = ServerIsWork;
  const factory InternetServerConnectionState.error(String message) = Error;
}
