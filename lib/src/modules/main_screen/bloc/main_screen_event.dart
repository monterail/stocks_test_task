part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class SearchTextChanged extends MainScreenEvent
    with _$SearchTextChangedAutoequalMixin {
  final String newText;

  const SearchTextChanged(this.newText);
}

@autoequalMixin
class SearchResultIsReady extends MainScreenEvent
    with _$SearchResultIsReadyAutoequalMixin {
  final List<SearchResultItem> items;

  const SearchResultIsReady(this.items);
}
