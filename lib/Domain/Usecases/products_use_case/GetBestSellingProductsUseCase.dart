import 'package:order_application/Data/Models/ResponseBody.dart';
import '../../../Data/Repository/products_repository.dart';

class GetBestSellingProductsUseCase {
  final ProductsRepository _repository;

  GetBestSellingProductsUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.fetchBestSelling();
  }
}
