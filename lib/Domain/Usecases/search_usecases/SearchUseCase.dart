import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/SearchType.dart';
import 'package:order_application/Data/Repository/search_repository.dart';

class SearchUseCase {
  final SearchRepository _repository;

  SearchUseCase(this._repository);

  Future<ResponseBody> call({
    required SearchType searchType,
    required String word,
    int page = 1,
  }) {
    return _repository.searchProducts(
      searchType: searchType,
      word: word,
      page: page,
    );
  }
}