import 'package:order_application/Data/Repository/orders_repository.dart';

class DeleteAnOrderUseCase {
  final OrderRepository _repository;

  DeleteAnOrderUseCase(this._repository);

  Future<void> call({
    required int id,
  }) {
    return _repository.deleteAnOrder(id);
  }
}
