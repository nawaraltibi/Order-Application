import 'package:order_application/Data/Repository/card_repository.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';

class GetAllCardsUseCase {
  final CardRepository _repository;

  GetAllCardsUseCase(this._repository);

  Future<ResponseBody> call() {
    return _repository.getAllCards();
  }
}