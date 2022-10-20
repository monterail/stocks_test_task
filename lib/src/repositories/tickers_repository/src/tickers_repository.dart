import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:template/src/config/api/exceptions.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';
import 'package:template/src/repositories/tickers_repository/src/models/timespan.dart';
import 'package:template/src/repositories/tickers_repository/src/models/stock_data.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';

class TickersRepository implements ITickersRepository {
  final Dio _apiClient;
  final GetTickerByName _getTickerByName;
  final GetStockData _getStockData;

  const TickersRepository({
    required Dio apiClient,
    required GetTickerByName getTickerByName,
    required GetStockData getStockData,
  })  : _apiClient = apiClient,
        _getTickerByName = getTickerByName,
        _getStockData = getStockData;

  @override
  Future<List<SearchResultItem>> searchTickerByName(String name) async {
    final response = await _getTickerByName(_apiClient, name);
    try {
      return List<SearchResultItem>.from(
        (response.data['results'] as List).map(
          (e) => SearchResultItem.fromJson(e),
        ),
      );
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }

  @override
  Future<List<StockData>> getStockData({
    required String ticker,
    required DateTime from,
    required DateTime to,
    required Timespan timespan,
  }) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final response = await _getStockData(
      _apiClient,
      ticker,
      dateFormat.format(from),
      dateFormat.format(to),
      timespan,
    );

    try {
      return List<StockData>.from(
        (response.data['results'] as List).map(
          (e) => StockData.fromJson(e),
        ),
      );
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
