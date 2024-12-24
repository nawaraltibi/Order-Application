import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/user_repository.dart';

class GetAuthenticatedUserUseCase {
  final UserRepository _repository;

  GetAuthenticatedUserUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.getAuthenticatedUser();
  }
}