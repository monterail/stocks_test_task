enum Timespan {
  day,
  week,
}

extension GetValue on Timespan {
  String get value {
    switch (this) {
      case Timespan.day:
        return 'day';
      case Timespan.week:
        return 'week';
    }
  }
}
