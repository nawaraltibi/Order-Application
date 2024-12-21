import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.logout();
  }
}