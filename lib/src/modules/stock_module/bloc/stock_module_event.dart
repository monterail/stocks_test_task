part of 'stock_module_bloc.dart';

abstract class StockModuleEvent extends Equatable {
  const StockModuleEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitStockModule extends StockModuleEvent
    with _$InitStockModuleAutoequalMixin {
  final SearchResultItem stockInfo;

  const InitStockModule({required this.stockInfo});
}

@autoequalMixin
class TimeRangeChanged extends StockModuleEvent
    with _$TimeRangeChangedAutoequalMixin {
  final TimeRange newTimeRange;

  const TimeRangeChanged({required this.newTimeRange});
}
