import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/Repository/auth_repository.dart';

class ResendVerificationCodeUseCase {
  final AuthRepository _repository;

  ResendVerificationCodeUseCase(this._repository);

  Future<Map<String, dynamic>> call(User user) {
    return _repository.resendVerificationCode(user);
  }
}