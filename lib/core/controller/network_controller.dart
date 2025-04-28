import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  List<ConnectivityResult> connectivityResult=[];
  final Connectivity _connectivity=Connectivity();
  @override
  void onInit() {
     super.onInit();
     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
     _updateConnectionStatus(connectivityResult);
  }
  void _updateConnectionStatus(List<ConnectivityResult> cr)async{
    connectivityResult  = await (_connectivity.checkConnectivity());
    if(cr.contains(ConnectivityResult.none)){
      Get.rawSnackbar(
        messageText: Text("No Internet"),
            duration: Duration(days: 1),
        isDismissible: false,
        backgroundColor: Colors.red,
        snackStyle: SnackStyle.GROUNDED
      );
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}