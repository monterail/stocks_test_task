import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';

abstract class ITickersRepository {
  Future<List<SearchResultItem>> searchTickerByName(String name);
}
