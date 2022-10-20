part of 'main_screen_bloc.dart';

@autoequalMixin
class MainScreenState extends Equatable with _$MainScreenStateAutoequalMixin {
  final List<SearchResultItem> resultItems;
  final String searchText;
  final bool isSearching;
  final SearchResultItem? selectedTicker;

  const MainScreenState({
    this.resultItems = const [],
    this.searchText = '',
    this.isSearching = false,
    this.selectedTicker,
  });

  MainScreenState copyWith({
    List<SearchResultItem>? resultItems,
    String? searchText,
    bool? isSearching,
    SearchResultItem? selectedTicker,
  }) =>
      MainScreenState(
        resultItems: resultItems ?? this.resultItems,
        searchText: searchText ?? this.searchText,
        isSearching: isSearching ?? this.isSearching,
        selectedTicker: selectedTicker ?? this.selectedTicker,
      );
}
