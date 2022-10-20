class ApiResponseParseException implements Exception {
  final String cause;
  const ApiResponseParseException(this.cause);

  @override
  String toString() => '$runtimeType: $cause';
}
