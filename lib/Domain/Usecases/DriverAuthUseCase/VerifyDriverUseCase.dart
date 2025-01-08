import 'package:order_application/Data/Models/Driver.dart';
import 'package:order_application/Data/Repository/driver_auth_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class VerifyDriverUseCase {
  final DriverAuthRepository _repository;

  VerifyDriverUseCase(this._repository);

  Future<ResponseBody> call(Driver driver) {
    return _repository.verifyDriver(driver);
  }
}