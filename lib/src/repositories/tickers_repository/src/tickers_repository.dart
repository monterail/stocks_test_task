import 'package:dio/dio.dart';
import 'package:template/src/config/api/exceptions.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';

class TickersRepository implements ITickersRepository {
  final Dio _apiClient;
  final GetTickerByName _getTickerByName;

  const TickersRepository({
    required Dio apiClient,
    required GetTickerByName getTickerByName,
  })  : _apiClient = apiClient,
        _getTickerByName = getTickerByName;

  @override
  Future<List<SearchResultItem>> searchTickerByName(String name) async {
    final response = await _getTickerByName(_apiClient, name);
    try {
      return List<SearchResultItem>.from(
        (response.data['results'] as List)
            .map((e) => SearchResultItem.fromJson(e))
            .toList(),
      );
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
