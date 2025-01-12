import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';

class GetUnTakenOrdersUseCase {
  final OrderRepository _repository;

  GetUnTakenOrdersUseCase(this._repository);

  Future<ResponseBody> call({
    int page = 1,
  }) {
    return _repository.getUnTakenOrders(page);
  }
}