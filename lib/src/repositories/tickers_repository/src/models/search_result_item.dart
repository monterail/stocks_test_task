import 'package:json_annotation/json_annotation.dart';

part 'search_result_item.g.dart';

@JsonSerializable()
class SearchResultItem {
  final String ticker;
  final String name;

  const SearchResultItem({required this.ticker, required this.name});

  factory SearchResultItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResultItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultItemToJson(this);
}
