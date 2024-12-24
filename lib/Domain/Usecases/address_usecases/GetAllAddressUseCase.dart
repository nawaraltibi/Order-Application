import 'package:order_application/Data/Repository/address_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class GetAllAddressUseCase {
  final AddressRepository _repository;

  GetAllAddressUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.getAllAddress();
  }
}