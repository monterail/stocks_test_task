part of 'stock_module_bloc.dart';

@autoequalMixin
class StockModuleState extends Equatable with _$StockModuleStateAutoequalMixin {
  final List<StockData>? stockData;
  final SearchResultItem? stockItem;
  final TimeRange timeRange;
  final bool isLoading;

  const StockModuleState({
    this.stockData,
    this.stockItem,
    this.timeRange = TimeRange.twoYears,
    this.isLoading = true,
  });

  StockModuleState copyWith({
    List<StockData>? stockData,
    SearchResultItem? stockItem,
    TimeRange? timeRange,
    bool? isLoading,
  }) =>
      StockModuleState(
        stockData: stockData ?? this.stockData,
        stockItem: stockItem ?? this.stockItem,
        timeRange: timeRange ?? this.timeRange,
        isLoading: isLoading ?? this.isLoading,
      );
}
