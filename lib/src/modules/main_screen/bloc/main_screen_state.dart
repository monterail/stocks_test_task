part of 'main_screen_bloc.dart';

@autoequalMixin
class MainScreenState extends Equatable with _$MainScreenStateAutoequalMixin {
  final List<SearchResultItem> resultItems;
  final String searchText;
  final bool isSearching;
  final SearchResultItem? selectedTicker;
  final BlocError error;

  const MainScreenState({
    this.resultItems = const [],
    this.searchText = '',
    this.isSearching = false,
    this.selectedTicker,
    this.error = BlocError.none,
  });

  MainScreenState copyWith({
    List<SearchResultItem>? resultItems,
    String? searchText,
    bool? isSearching,
    SearchResultItem? selectedTicker,
    BlocError? error,
  }) =>
      MainScreenState(
        resultItems: resultItems ?? this.resultItems,
        searchText: searchText ?? this.searchText,
        isSearching: isSearching ?? this.isSearching,
        selectedTicker: selectedTicker ?? this.selectedTicker,
        error: error ?? this.error,
      );
}
