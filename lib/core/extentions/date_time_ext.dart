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

  static String dateLocalized(dynamic input) {
    return Jiffy(input).format("do MMMM yyyy kk:mm aaa");
  }

  static DateTime get currentDateTime {
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(current).toString());
  }

  static String ddMmYyyy(DateTime dateTime) {
    return Jiffy(dateTime).format("dd.MM.yyyy");
  }
}
