import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';

class TakeAnOrderUseCase {
  final OrderRepository _repository;

  TakeAnOrderUseCase(this._repository);

  Future<ResponseBody> call({
    required int id,
  }) {
    return _repository.takeAnOrder(id);
  }
}
