import 'package:pharmacy/core/network/api_service.dart';

class InternetServerConnectionRepository {
  final ApiService _apiService;
  InternetServerConnectionRepository(this._apiService);
  Future<bool> checkServerStatus() async{
    return _apiService.checkServerStatus();
  }
}