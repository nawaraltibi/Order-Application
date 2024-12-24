import 'package:order_application/Data/Repository/card_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class GetAnCardsUseCase {
  final CardRepository _repository;

  GetAnCardsUseCase(this._repository);

  Future<ResponseBody> call(int id) {
    return _repository.getAnCards(id);
  }
}