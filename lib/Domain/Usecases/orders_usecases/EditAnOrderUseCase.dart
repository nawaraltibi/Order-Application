import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';

class EditAnOrderUseCase {
  final OrderRepository _repository;

  EditAnOrderUseCase(this._repository);

  Future<ResponseBody> call({
    required Order order,
    required int id,
  }) {
    return _repository.editAnOrder(order, id);
  }
}
