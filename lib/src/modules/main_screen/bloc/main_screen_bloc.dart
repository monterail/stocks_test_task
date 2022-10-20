import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';

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
  }

  void _onTickerSelected(
    TickerSelected event,
    Emitter<MainScreenState> emit,
  ) {
    emit(state.copyWith(
      selectedTicker: event.ticker,
      searchText: '',
      isSearching: false,
    ));
  }

  void _onSearchResultIsReady(
    SearchResultIsReady event,
    Emitter<MainScreenState> emit,
  ) {
    emit(state.copyWith(resultItems: event.items, isSearching: false));
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
    ));
  }

  void _timerUpdater(Timer timer) {
    if (timer.tick > 3) {
      _fetchSearch();
      _timer?.cancel();
    }
  }

  Future<void> _fetchSearch() async {
    final results = await _tickersRepository.searchTickerByName(
      state.searchText,
    );

    add(SearchResultIsReady(results));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
