import 'package:dio/dio.dart';

typedef GetTickerByName = Future<Response> Function(Dio, String);

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
