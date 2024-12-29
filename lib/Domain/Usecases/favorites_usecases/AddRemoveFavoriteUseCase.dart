import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/favorites_repository.dart';

class AddRemoveFavoriteUseCase {
  final FavoritesRepository _repository;

  AddRemoveFavoriteUseCase(this._repository);

  Future<ResponseBody> call({
    required int id,
  }) {
    return _repository.addRemove(
      productId: id,
    );
  }
}