import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Repository/favorites_repository.dart';

class ShowFavoritesUseCase {
  final FavoritesRepository _repository;

  ShowFavoritesUseCase(this._repository);

  Future<ResponseBody> call({
    int page = 1,
  }) {
    return _repository.showFavorites(
      page: page,
    );
  }
}