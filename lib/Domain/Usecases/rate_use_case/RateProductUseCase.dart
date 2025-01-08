import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/rate_repository.dart';

class RateProductUseCase {
  final RateRepository _repository;

  RateProductUseCase(this._repository);

  Future<ResponseBody> call({
    required String rateableType,
    required int rateableId,
    required int rate,
  }) {
    return _repository.rate(
      rateableType: rateableType,
      rateableId: rateableId,
      rate: rate,
    );
  }
}
