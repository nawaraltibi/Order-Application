import 'package:order_application/Data/Models/Driver.dart';
import 'package:order_application/Data/Repository/driver_auth_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class RegisterDriverUseCase {
  final DriverAuthRepository _repository;

  RegisterDriverUseCase(this._repository);

  Future<ResponseBody> call(Driver driver) {
    return _repository.registerDriver(driver);
  }
}
