import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';

class DeliverAnOrderUseCase {
  final OrderRepository _repository;

  DeliverAnOrderUseCase(this._repository);

  Future<ResponseBody> call({
    required int id,
  }) {
    return _repository.deliverAnOrder(id);
  }
}
