import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';

class CreateAnOrderUseCase {
  final OrderRepository _repository;

  CreateAnOrderUseCase(this._repository);

  Future<ResponseBody> call({
    required Order order,
  }) {
    return _repository.createAnOrder(order);
  }
}
