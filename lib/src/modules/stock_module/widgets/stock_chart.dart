import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:template/src/modules/stock_module/utils/stock_utils.dart';
import 'package:template/src/repositories/tickers_repository/src/models/stock_data.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StockChart extends StatelessWidget {
  final List<StockData> stockData;

  const StockChart({
    Key? key,
    required this.stockData,
  }) : super(key: key);

  List<TouchedSpotIndicatorData?> _getTouchedSpotIndicator(
    _,
    List<int> spotIndexes,
  ) {
    return spotIndexes
        .map((e) => TouchedSpotIndicatorData(
              FlLine(color: Colors.green, strokeWidth: 1),
              FlDotData(getDotPainter: _getDotPainter),
            ))
        .toList();
  }

  FlDotCirclePainter _getDotPainter(_, __, ___, ____) => FlDotCirclePainter(
        color: Colors.green,
        radius: 4,
        strokeWidth: 0,
      );

  List<FlSpot> _generateSpots() => stockData
      .mapIndexed(
        (index, element) => FlSpot(index.toDouble(), element.closePrice),
      )
      .toList();

  List<LineTooltipItem> _getTooltipItems(
    List<LineBarSpot> touchedSpots,
    BuildContext context,
  ) {
    return touchedSpots
        .map((e) => LineTooltipItem(
              '${AppLocalizations.of(context)!.date}: ${StockUtils.getFormattedDateFromTs(stockData[e.spotIndex].timestamp)}\n',
              const TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              children: [
                TextSpan(
                  text:
                      '${AppLocalizations.of(context)!.closePrice}: \$${stockData[e.spotIndex].closePrice}\n',
                ),
                TextSpan(
                  text:
                      '${AppLocalizations.of(context)!.openPrice}: \$${stockData[e.spotIndex].openPrice}',
                ),
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: stockData.length.toDouble(),
          minY: stockData.map((e) => e.closePrice).min,
          maxY: stockData.map((e) => e.closePrice).max,
          lineBarsData: [
            LineChartBarData(
              spots: _generateSpots(),
              color: Colors.green,
              barWidth: 2.5,
              dotData: FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            getTouchedSpotIndicator: _getTouchedSpotIndicator,
            touchTooltipData: LineTouchTooltipData(
              maxContentWidth: 300,
              getTooltipItems: (data) => _getTooltipItems(data, context),
              tooltipRoundedRadius: 2,
              tooltipBorder: BorderSide.none,
            ),
          ),
          gridData: FlGridData(show: false),
        ),
        swapAnimationDuration: const Duration(milliseconds: 350),
      ),
    );
  }
}
