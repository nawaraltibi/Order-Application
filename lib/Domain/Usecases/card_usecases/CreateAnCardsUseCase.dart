import 'package:order_application/Data/Models/CreditCard.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/card_repository.dart';

class CreateAnCardsUseCase {
  final CardRepository _repository;

  CreateAnCardsUseCase(this._repository);

  Future<ResponseBody> call(CreditCard card) {
    return _repository.createAnCards(card);
  }
}