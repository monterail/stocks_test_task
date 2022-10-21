import 'package:autoequal/autoequal.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:template/src/modules/stock_module/utils/stock_utils.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';
import 'package:template/src/repositories/tickers_repository/src/models/stock_data.dart';
import 'package:template/src/repositories/tickers_repository/src/models/time_range.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';
import 'package:template/src/utils/bloc_exception.dart';

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
        error: BlocError.none,
      ));
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode ?? 0;
      switch (statusCode) {
        case StatusCode.UNAUTHORIZED:
          _emitErrorState(BlocError.unauthorized, emit);
          break;
        case StatusCode.TOO_MANY_REQUESTS:
          _emitErrorState(BlocError.tooManyRequests, emit);
          break;
        default:
          _emitErrorState(BlocError.serverError, emit);
          break;
      }
    }
  }

  void _onTimeRangeChanged(
    TimeRangeChanged event,
    Emitter<StockModuleState> emit,
  ) {
    emit(state.copyWith(timeRange: event.newTimeRange));
    add(InitStockModule(stockInfo: state.stockItem!));
  }

  BlocException _emitErrorState(
    BlocError error,
    Emitter<StockModuleState> emit,
  ) {
    emit(state.copyWith(error: error));
    return BlocException(error.text);
  }
}
