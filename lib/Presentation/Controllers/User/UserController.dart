import 'package:get/get.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Domain/Usecases/user_usecases/GetAuthenticatedUserUseCase.dart';

class UserController extends GetxController {
  final GetAuthenticatedUserUseCase getAuthenticatedUserUseCase;

  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;

  Rx<User> user = Rx<User>(User.empty());

  @override
  void onInit() {
    super.onInit();
    loadingMap['getAuthenticatedUser'] = false.obs;
  }

  UserController({
    required this.getAuthenticatedUserUseCase,
  });

  Future<void> getAuthenticatedUser() async {
    final ResponseBody response = await getAuthenticatedUserUseCase.call();
    user.value = User.fromJson(response.data!);
    await controllerHandling(
      () async {

      },
      loadingMap,
      'getAuthenticatedUser',
      errorMap,
      'getAuthenticatedUser',
    );
  }
}