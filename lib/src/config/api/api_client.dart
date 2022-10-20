import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:template/src/environment/variables.dart';

class ApiClient {
  const ApiClient();

  Dio _createApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentVariables.baseUrl,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': 'Bearer ${EnvironmentVariables.polygonApiKey}',
        },
      ),
    );

    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    return dio;
  }

  Dio get client => _createApiClient();
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
