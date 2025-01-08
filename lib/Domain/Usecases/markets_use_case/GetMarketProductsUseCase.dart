import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/markets_repository.dart';

class GetMarketProductsUseCase {
  final MarketsRepository _repository;

  GetMarketProductsUseCase(this._repository);

  Future<ResponseBody> call({
    required int marketId,
    required int page,
  }) {
    return _repository.getProducts(
      marketId: marketId,
      page: page,
    );
  }
}
