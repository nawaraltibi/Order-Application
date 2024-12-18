import 'package:order_application/Data/Repository/auth_repository.dart';
import 'package:order_application/Data/Models/User.dart';

class RegisterUserUseCase {
  final AuthRepository _repository;

  RegisterUserUseCase(this._repository);

  Future<Map<String, dynamic>> call(User user) {
    return _repository.registerUser(user);
  }
}