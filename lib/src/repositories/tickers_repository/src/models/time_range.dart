import 'package:template/src/repositories/tickers_repository/src/models/timespan.dart';

enum TimeRange {
  oneWeek,
  oneMonth,
  threeMonths,
  oneYear,
  twoYears,
}

extension GetValue on TimeRange {
  String get value {
    switch (this) {
      case TimeRange.oneWeek:
        return '1W';
      case TimeRange.oneMonth:
        return '1M';
      case TimeRange.threeMonths:
        return '3M';
      case TimeRange.oneYear:
        return '1Y';
      case TimeRange.twoYears:
        return '2Y';
    }
  }

  Timespan get timespanValue {
    switch (this) {
      case TimeRange.oneWeek:
      case TimeRange.oneMonth:
        return Timespan.day;
      case TimeRange.threeMonths:
      case TimeRange.oneYear:
      case TimeRange.twoYears:
        return Timespan.week;
    }
  }
}
