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
    return DateFormat('yyyy-MM-dd', "en").format(current).toString();
  }

  static String serverFormatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd', "en").format(dateTime).toString();
  }

  static String dateLocalized(DateTime input) {
    return DateFormat(
            "d${getDayOfMonthSuffix(input.day)} MMMM yyyy hh:mm aaa", "en")
        .format(input);
  }

  static String localizedDdMm(dynamic input) {
    return DateFormat("d MMM", "en").format(input);
  }

  static String localizedDdMmOneLine(DateTime input) {
    return DateFormat("d${getDayOfMonthSuffix(input.day)} MMM", "en")
        .format(input);
  }

  static String localizedDdMmYyyy(DateTime input) {
    return DateFormat("d${getDayOfMonthSuffix(input.day)} MMM yyyy", "en")
        .format(input);
  }

  static DateTime get currentDateTime {
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(current).toString());
  }

  static String ddMmYyyy(DateTime dateTime) {
    return DateFormat("dd.MM.yyyy", "en").format(dateTime);
  }

  static String yyyyMmDd(DateTime dateTime) {
    return DateFormat("yyyy.MM.dd", "en").format(dateTime);
  }

  static String miniDate(String dateTimeString) {
    var dateString = dateTimeString.split(" ")[0].split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),
        int.parse(dateString[0]), int.parse(dateString[1]));
    return CustomizableDateTime.localizedDdMm(dateTime);
  }

  static String miniDateWithYear(String dateTimeString) {
    var dateString = dateTimeString.split(" ")[0].split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),
        int.parse(dateString[0]), int.parse(dateString[1]));
    return "${CustomizableDateTime.localizedDdMm(dateTime)} ${dateString[2]}";
  }

  static String miniDateOneLine(String dateTimeString) {
    var dateString = dateTimeString.split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),
        int.parse(dateString[0]), int.parse(dateString[1]));
    return CustomizableDateTime.localizedDdMmYyyy(dateTime);
  }

  static String getDayOfMonthSuffix(int dayNum) {
    return "";
  }
}
