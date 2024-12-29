import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';

class GetAllOrdersUseCase {
  final OrderRepository _repository;

  GetAllOrdersUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.getAllOrders();
  }
}
