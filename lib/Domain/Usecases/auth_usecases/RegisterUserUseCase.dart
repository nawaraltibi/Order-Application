import 'package:order_application/Data/Repository/auth_repository.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class RegisterUserUseCase {
  final AuthRepository _repository;

  RegisterUserUseCase(this._repository);

  Future<ResponseBody> call(User user) {
    return _repository.registerUser(user);
  }
}