part of 'main_screen_bloc.dart';

@autoequalMixin
class MainScreenState extends Equatable with _$MainScreenStateAutoequalMixin {
  final List<SearchResultItem> resultItems;
  final String searchText;
  final bool isSearching;

  const MainScreenState({
    this.resultItems = const [],
    this.searchText = '',
    this.isSearching = false,
  });

  MainScreenState copyWith({
    List<SearchResultItem>? resultItems,
    String? searchText,
    bool? isSearching,
  }) =>
      MainScreenState(
        resultItems: resultItems ?? this.resultItems,
        searchText: searchText ?? this.searchText,
        isSearching: isSearching ?? this.isSearching,
      );
}
