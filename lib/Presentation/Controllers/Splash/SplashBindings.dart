import 'package:get/get.dart';
import 'package:order_application/Data/Repository/user_repository.dart';
import 'package:order_application/Domain/Usecases/user_usecases/GetAuthenticatedUserUseCase.dart';
import 'package:order_application/Presentation/Controllers/Splash/SplashController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import '../../../Data/Repository/orders_repository.dart';
import '../../../Domain/Usecases/orders_usecases/DeliverAnOrderUseCase.dart';
import '../../../Domain/Usecases/orders_usecases/GetActiveOrderUseCase.dart';
import '../../../Domain/Usecases/orders_usecases/GetUnTakenOrdersUseCase.dart';
import '../../../Domain/Usecases/orders_usecases/TakeAnOrderUseCase.dart';
import '../Driver/DriverController.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    // Inject DriverController dependency
    Get.put<DriverController>(
      DriverController(
        getActiveOrderUseCase: GetActiveOrderUseCase(OrderRepository()),
        getUnTakenOrdersUseCase: GetUnTakenOrdersUseCase(OrderRepository()),
        takeAnOrderUseCase: TakeAnOrderUseCase(OrderRepository()),
        deliverAnOrderUseCase: DeliverAnOrderUseCase(OrderRepository()),
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

    // Inject SplashController dependency
    Get.lazyPut(() => SplashController());
  }
}
