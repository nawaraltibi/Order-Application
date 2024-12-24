import 'package:order_application/Data/Repository/address_repository.dart';

class DeleteAnAddressUseCase {
  final AddressRepository _repository;

  DeleteAnAddressUseCase(this._repository);

  Future<void> call(int id) {
    return _repository.deleteAnAddress(id);
  }
}