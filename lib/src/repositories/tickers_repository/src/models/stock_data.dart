import 'package:json_annotation/json_annotation.dart';

part 'stock_data.g.dart';

@JsonSerializable()
class StockData {
  @JsonKey(name: 't')
  final int timestamp;

  @JsonKey(name: 'c')
  final double closePrice;

  @JsonKey(name: 'o')
  final double openPrice;

  const StockData({
    required this.timestamp,
    required this.closePrice,
    required this.openPrice,
  });

  factory StockData.fromJson(Map<String, dynamic> json) =>
      _$StockDataFromJson(json);

  Map<String, dynamic> toJson() => _$StockDataToJson(this);
}
