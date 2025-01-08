import 'package:get/get.dart';
import 'package:order_application/Data/Repository/auth_repository.dart';
import 'package:order_application/Data/Repository/driver_auth_repository.dart';
import 'package:order_application/Domain/Usecases/DriverAuthUseCase/RegisterDriverUseCase.dart';
import 'package:order_application/Domain/Usecases/DriverAuthUseCase/ResendVerificationCodeUseCaseForDriver.dart';
import 'package:order_application/Domain/Usecases/DriverAuthUseCase/VerifyDriverUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/RegisterUserUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/ResendVerificationCodeUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/VerifyUserUseCase.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => RegisterUserUseCase(AuthRepository()));
    Get.lazyPut(() => ResendVerificationCodeUseCase(AuthRepository()));
    Get.lazyPut(() => VerifyUserUseCase(AuthRepository()));

    Get.lazyPut(() => RegisterDriverUseCase(DriverAuthRepository()));
    Get.lazyPut(() => ResendVerificationCodeUseCaseForDriver(DriverAuthRepository()));
    Get.lazyPut(() => VerifyDriverUseCase(DriverAuthRepository()));

    Get.put(AuthController(
      registerUserUseCase: Get.find(),
      resendVerificationCodeUseCase: Get.find(),
      verifyUserUseCase: Get.find(),
      registerDriverUseCase: Get.find(),
      resendVerificationCodeUseCaseForDriver: Get.find(),
      verifyDriverUseCase: Get.find(),
    ));
  }
}