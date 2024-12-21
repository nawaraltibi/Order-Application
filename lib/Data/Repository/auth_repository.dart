import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/apis/auth_api.dart';

class AuthRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> registerUser(User user) async {
    final request = AuthAPI.register(user);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> resendVerificationCode(User user) async {
    final request = AuthAPI.resendVerificationCode(user);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> verifyUser(User user) async {
    final request = AuthAPI.verify(user);
    print(request.body);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> fillUserData(User user) async {
    final request = AuthAPI.fillStudentData(user: user);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> logout() async {
    final request = AuthAPI.logout();
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }
}
