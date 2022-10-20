import 'package:flutter/material.dart';
import 'package:template/src/repositories/tickers_repository/src/models/search_result_item.dart';

class StockHeader extends StatelessWidget {
  final SearchResultItem stockInfo;
  final double priceToday;

  const StockHeader({
    Key? key,
    required this.stockInfo,
    required this.priceToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      child: Text(
        '${stockInfo.name} (${stockInfo.ticker})\n\$$priceToday',
        key: ValueKey(stockInfo.ticker),
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
