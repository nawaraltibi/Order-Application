import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/Repository/auth_repository.dart';

class FillUserDataUseCase {
  final AuthRepository _repository;

  FillUserDataUseCase(this._repository);

  Future<ResponseBody> call(User user) {
    return _repository.fillUserData(user);
  }
}