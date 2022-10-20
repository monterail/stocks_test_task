import 'package:intl/intl.dart';
import 'package:template/src/repositories/tickers_repository/src/models/time_range.dart';

class StockUtils {
  static DateTime getFromDateByTimeRange(TimeRange timeRange) {
    final now = DateTime.now();

    switch (timeRange) {
      case TimeRange.oneWeek:
        return now.subtract(const Duration(days: 7));
      case TimeRange.oneMonth:
        return now.subtract(const Duration(days: 30));
      case TimeRange.threeMonths:
        return now.subtract(const Duration(days: 32));
      case TimeRange.oneYear:
        return now.subtract(const Duration(days: 365));
      case TimeRange.twoYears:
        return now.subtract(const Duration(days: 730));
    }
  }

  static String getFormattedDateFromTs(int ts) {
    final date = DateTime.fromMillisecondsSinceEpoch(ts);
    final format = DateFormat('dd-MM-yyyy');

    return format.format(date);
  }
}
