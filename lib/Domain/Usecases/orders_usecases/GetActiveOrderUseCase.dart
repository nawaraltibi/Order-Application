import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';

class GetActiveOrderUseCase {
  final OrderRepository _repository;

  GetActiveOrderUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.getActiveOrder();
  }
}
