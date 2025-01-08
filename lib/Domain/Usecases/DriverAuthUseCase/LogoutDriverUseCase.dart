import 'package:order_application/Data/Repository/driver_auth_repository.dart';

class LogoutDriverUseCase {
  final DriverAuthRepository _repository;

  LogoutDriverUseCase(this._repository);

  Future<void> call() {
    return _repository.logout();
  }
}
