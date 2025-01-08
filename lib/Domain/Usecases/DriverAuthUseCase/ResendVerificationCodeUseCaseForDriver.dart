import 'package:order_application/Data/Models/Driver.dart';
import 'package:order_application/Data/Repository/driver_auth_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class ResendVerificationCodeUseCaseForDriver {
  final DriverAuthRepository _repository;

  ResendVerificationCodeUseCaseForDriver(this._repository);

  Future<ResponseBody> call(Driver driver) {
    return _repository.resendVerificationCode(driver);
  }
}
