import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';
import 'package:template/src/utils/bloc_exception.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';
part 'main_screen_bloc.g.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final ITickersRepository _tickersRepository;
  Timer? _timer;

  MainScreenBloc({required ITickersRepository tickersRepository})
      : _tickersRepository = tickersRepository,
        super(const MainScreenState()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<SearchResultIsReady>(_onSearchResultIsReady);
    on<TickerSelected>(_onTickerSelected);
    on<ErrorHandled>(_onErrorHandled);
  }

  void _onTickerSelected(
    TickerSelected event,
    Emitter<MainScreenState> emit,
  ) {
    emit(state.copyWith(
      selectedTicker: event.ticker,
      searchText: '',
      isSearching: false,
      error: BlocError.none,
    ));
  }

  void _onSearchResultIsReady(
    SearchResultIsReady event,
    Emitter<MainScreenState> emit,
  ) {
    emit(state.copyWith(
      resultItems: event.items,
      isSearching: false,
      error: BlocError.none,
    ));
  }

  Future<void> _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<MainScreenState> emit,
  ) async {
    _timer?.cancel();

    if (event.newText.length > state.searchText.length &&
        event.newText.length > 2) {
      _timer = Timer.periodic(
        const Duration(milliseconds: 200),
        _timerUpdater,
      );
    }

    emit(state.copyWith(
      searchText: event.newText,
      resultItems: event.newText.isEmpty ? const [] : null,
      isSearching: event.newText.isEmpty ? false : true,
      error: BlocError.none,
    ));
  }

  void _timerUpdater(Timer timer) {
    if (timer.tick > 3) {
      _fetchSearch();
      _timer?.cancel();
    }
  }

  Future<void> _fetchSearch() async {
    try {
      final results = await _tickersRepository.searchTickerByName(
        state.searchText,
      );

      add(SearchResultIsReady(results));
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode ?? 0;

      switch (statusCode) {
        case StatusCode.UNAUTHORIZED:
          return add(const ErrorHandled(BlocError.unauthorized));
        case StatusCode.TOO_MANY_REQUESTS:
          return add(const ErrorHandled(BlocError.tooManyRequests));
        default:
          return add(const ErrorHandled(BlocError.serverError));
      }
    }
  }

  BlocException _onErrorHandled(
    ErrorHandled event,
    Emitter<MainScreenState> emit,
  ) {
    emit(state.copyWith(error: event.error));
    return BlocException(event.error.text);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
