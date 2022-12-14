import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

extension CustomizableDateTime on DateTime {
  static DateTime? _customTime;
  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }

  static String get currentDate {
    return DateFormat('yyyy-MM-dd').format(current).toString();
  }

  static String get currentDateLocalized {
    return Jiffy().format("do MMMM yyyy kk:mm aaa");
  }
}
