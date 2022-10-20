import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  static const _height = 50.0;
  static const _loaderIconSize = 16.0;

  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(_height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(_controllerListener);
    super.initState();
  }

  void _controllerListener() {
    context
        .read<MainScreenBloc>()
        .add(SearchTextChanged(_controller.value.text));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
            return SearchField<SearchResultItem>(
              controller: _controller,
              searchInputDecoration: InputDecoration(
                constraints: const BoxConstraints(
                  maxHeight: CustomAppBar._height,
                ),
                prefixIcon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: state.isSearching
                      ? const SizedBox(
                          width: CustomAppBar._loaderIconSize,
                          height: CustomAppBar._loaderIconSize,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.search),
                ),
                focusColor: Colors.green,
                border: const OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
              itemHeight: 64,
              suggestions: state.resultItems
                  .map(
                    (e) => SearchFieldListItem<SearchResultItem>(
                      e.ticker,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text('${e.name} (${e.ticker})'),
                      ),
                      item: e,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
