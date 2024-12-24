import 'package:order_application/Data/Repository/address_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class GetAnAddressUseCase {
  final AddressRepository _repository;

  GetAnAddressUseCase(this._repository);

  Future<ResponseBody> call(int id) {
    return _repository.getAnAddress(id);
  }
}