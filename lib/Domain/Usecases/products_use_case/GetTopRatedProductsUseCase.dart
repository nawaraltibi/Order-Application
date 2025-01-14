import 'package:order_application/Data/Models/ResponseBody.dart';
import '../../../Data/Repository/products_repository.dart';

class GetTopRatedProductsUseCase {
  final ProductsRepository _repository;

  GetTopRatedProductsUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.fetchTopRated();
  }
}
