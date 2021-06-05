import 'package:flutter/foundation.dart';

enum TimeType {
  days,
  weeks,
  months,
  years,
}

class Period {
  TimeType type;
  int period;
  Period({@required this.type, this.period = 0});

  List<int> typeOptions() {
    if (type == TimeType.days)
      return [0, 1, 2, 3, 4, 5, 6];
    else if (type == TimeType.weeks)
      return [0, 1, 2, 3];
    else if (type == TimeType.months)
      return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    else
      return [0, 1, 2, 3, 4, 5];
  }
}
