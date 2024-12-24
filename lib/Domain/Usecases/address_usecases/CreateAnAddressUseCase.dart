import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Repository/address_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class CreateAnAddressUseCase {
  final AddressRepository _repository;

  CreateAnAddressUseCase(this._repository);

  Future<ResponseBody> call(Location location) {
    return _repository.createAnAddress(location);
  }
}