import 'package:order_application/Data/Repository/card_repository.dart';

class DeleteAnCardsUseCase {
  final CardRepository _repository;

  DeleteAnCardsUseCase(this._repository);

  Future<void> call(int id) {
    return _repository.deleteAnCards(id);
  }
}