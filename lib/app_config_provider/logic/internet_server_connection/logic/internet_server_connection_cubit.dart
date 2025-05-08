import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/app_config_provider/logic/internet_server_connection/repository/internet_server_connection_repository.dart';
import 'internet_server_connection_state.dart';

class InternetServerConnectionCubit
    extends Cubit<InternetServerConnectionState> {
  final Connectivity _connectivity;
  final InternetServerConnectionRepository _repository;
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  InternetServerConnectionCubit(this._connectivity, this._repository)
      : super(const Initial()) {
    // Start listening on construction
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
    emitDeviceIsConnected(); // Also check on init
  }

  Future<void> emitDeviceIsConnected() async {
    emit(const Loading());

    try {
      final results = await _connectivity.checkConnectivity();

      if (results.contains(ConnectivityResult.none)) {
        emit(const Error("No internet connection. Please connect to the Internet."));
        return;
      }

      // Check server status
      final isServerOnline = await _repository.checkServerStatus();
      if (isServerOnline) {
        emit(const ServerIsWork());
      } else {
        emit(const DeviceIsConnected("The service is currently down. Please try again later."));
      }
    } catch (e) {
      emit(const Error("The service is currently down. Please try again later."));
    }
  }

  Future<void> _handleConnectivityChange(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      emit(const Error("No internet connection. Please connect to the Internet."));
    } else {
      await emitDeviceIsConnected();
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
