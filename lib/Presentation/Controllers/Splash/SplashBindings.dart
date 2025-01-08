import 'package:get/get.dart';
import 'package:order_application/Data/Repository/user_repository.dart';
import 'package:order_application/Domain/Usecases/user_usecases/GetAuthenticatedUserUseCase.dart';
import 'package:order_application/Presentation/Controllers/Splash/SplashController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';

import '../Driver/DriverController.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {

    // Inject DriverController dependency
    Get.put<DriverController>(
      DriverController(
      ),
      permanent: true,
    );

    // Inject UserController dependency
    Get.put<UserController>(
      UserController(
        getAuthenticatedUserUseCase: GetAuthenticatedUserUseCase(UserRepository()),
      ),
      permanent: true,
    );

    Get.lazyPut(() => SplashController());

  }
}