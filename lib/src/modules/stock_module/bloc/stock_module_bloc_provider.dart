import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/modules/stock_module/bloc/stock_module_bloc.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';

class StockModuleBlocProvider extends StatelessWidget {
  final Widget child;

  const StockModuleBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = StockModuleBloc(
          tickersRepository: context.read<ITickersRepository>(),
        );

        final selectedTicker =
            context.read<MainScreenBloc>().state.selectedTicker!;
        bloc.add(InitStockModule(stockInfo: selectedTicker));

        return bloc;
      },
      child: child,
    );
  }
}
