import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/Repository/auth_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class VerifyUserUseCase {
  final AuthRepository _repository;

  VerifyUserUseCase(this._repository);

  Future<ResponseBody> call(User user) {
    return _repository.verifyUser(user);
  }
}