import 'package:dio/dio.dart';
import 'package:template/src/repositories/tickers_repository/src/models/timespan.dart';

typedef GetTickerByName = Future<Response> Function(Dio, String);
typedef GetStockData = Future<Response> Function(
  Dio,
  String,
  String,
  String,
  Timespan,
);

final GetTickerByName getTickerByName = (
  Dio apiClient,
  String name,
) =>
    apiClient.get(
      '/v3/reference/tickers',
      queryParameters: {
        'market': 'stocks',
        'limit': 10,
        'search': name,
      },
    );

final GetStockData getStockData = (
  Dio apiClient,
  String ticker,
  String from,
  String to,
  Timespan timespan,
) =>
    apiClient.get(
      '/v2/aggs/ticker/$ticker/range/1/${timespan.value}/$from/$to',
    );
