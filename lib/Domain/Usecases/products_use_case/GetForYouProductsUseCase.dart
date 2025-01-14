import 'package:order_application/Data/Models/ResponseBody.dart';
import '../../../Data/Repository/products_repository.dart';

class GetForYouProductsUseCase {
  final ProductsRepository _repository;

  GetForYouProductsUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.fetchForYou();
  }
}