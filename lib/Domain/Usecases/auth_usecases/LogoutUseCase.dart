import 'package:order_application/Data/Repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Map<String, dynamic>> call() {
    return _repository.logout();
  }
}