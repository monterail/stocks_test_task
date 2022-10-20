import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';
import 'package:template/src/repositories/tickers_repository/src/models/stock_data.dart';
import 'package:template/src/repositories/tickers_repository/src/models/timespan.dart';

abstract class ITickersRepository {
  Future<List<SearchResultItem>> searchTickerByName(String name);

  Future<List<StockData>> getStockData({
    required String ticker,
    required DateTime from,
    required DateTime to,
    required Timespan timespan,
  });
}
