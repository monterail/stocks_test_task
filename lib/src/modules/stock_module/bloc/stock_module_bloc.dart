import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/stock_module/utils/stock_utils.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';
import 'package:template/src/repositories/tickers_repository/src/models/stock_data.dart';
import 'package:template/src/repositories/tickers_repository/src/models/time_range.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';

part 'stock_module_event.dart';
part 'stock_module_state.dart';
part 'stock_module_bloc.g.dart';

class StockModuleBloc extends Bloc<StockModuleEvent, StockModuleState> {
  final ITickersRepository _tickersRepository;

  StockModuleBloc({
    required ITickersRepository tickersRepository,
  })  : _tickersRepository = tickersRepository,
        super(const StockModuleState()) {
    on<InitStockModule>(_onInitStockModule);
    on<TimeRangeChanged>(_onTimeRangeChanged);
  }

  Future<void> _onInitStockModule(
    InitStockModule event,
    Emitter<StockModuleState> emit,
  ) async {
    try {
      final from = StockUtils.getFromDateByTimeRange(state.timeRange);
      final stockData = await _tickersRepository.getStockData(
        ticker: event.stockInfo.ticker,
        from: from,
        to: DateTime.now(),
        timespan: state.timeRange.timespanValue,
      );

      emit(state.copyWith(
        stockData: stockData,
        stockItem: event.stockInfo,
        isLoading: false,
      ));
    } catch (e) {
      print(e);
    }
  }

  void _onTimeRangeChanged(
    TimeRangeChanged event,
    Emitter<StockModuleState> emit,
  ) {
    emit(state.copyWith(timeRange: event.newTimeRange));
    add(InitStockModule(stockInfo: state.stockItem!));
  }
}
