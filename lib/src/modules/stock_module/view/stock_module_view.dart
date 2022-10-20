import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/modules/stock_module/bloc/stock_module_bloc.dart';
import 'package:template/src/modules/stock_module/bloc/stock_module_bloc_provider.dart';
import 'package:template/src/modules/stock_module/widgets/stock_chart.dart';
import 'package:template/src/modules/stock_module/widgets/stock_footer.dart';
import 'package:template/src/modules/stock_module/widgets/stock_header.dart';

class StockModuleView extends StatelessWidget {
  const StockModuleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StockModuleBlocProvider(
      child: BlocBuilder<StockModuleBloc, StockModuleState>(
        builder: (context, state) {
          return BlocListener<MainScreenBloc, MainScreenState>(
            listener: (context, mainScreenState) {
              if (state.stockItem?.ticker !=
                  mainScreenState.selectedTicker!.ticker) {
                context.read<StockModuleBloc>().add(InitStockModule(
                      stockInfo: mainScreenState.selectedTicker!,
                    ));
              }
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.isLoading && state.stockData == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StockHeader(
                            stockInfo: state.stockItem!,
                            priceToday: state.stockData!.last.openPrice,
                          ),
                          const SizedBox(height: 56),
                          StockChart(stockData: state.stockData!),
                          const SizedBox(height: 56),
                          const StockFooter()
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
