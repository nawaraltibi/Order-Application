import 'package:get/get.dart';
import 'package:order_application/Data/Repository/user_repository.dart';
import 'package:order_application/Domain/Usecases/user_usecases/GetAuthenticatedUserUseCase.dart';
import 'package:order_application/Presentation/Controllers/Splash/SplashController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<UserController>(() => UserController(
        getAuthenticatedUserUseCase: GetAuthenticatedUserUseCase(UserRepository())
    ));

    Get.lazyPut(() => SplashController());

  }
}