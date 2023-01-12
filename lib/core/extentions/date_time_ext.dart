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

  static String localizedDdMm(dynamic input) {
    return Jiffy(input).format("d MMM");
  }

  static String localizedDdMmOneLine(dynamic input) {
    return Jiffy(input).format("do MMM");
  }

  static String localizedDdMmYyyy(dynamic input) {
    return Jiffy(input).format("do MMM yyyy");
  }

  static DateTime get currentDateTime {
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(current).toString());
  }

  static String ddMmYyyy(DateTime dateTime) {
    return Jiffy(dateTime).format("dd.MM.yyyy");
  }

  static String yyyyMmDd(DateTime dateTime) {
    return Jiffy(dateTime).format("yyyy.MM.dd");
  }

  static String miniDate(String dateTimeString){
    var dateString = dateTimeString.split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),int.parse(dateString[0]),int.parse(dateString[1]));
    return CustomizableDateTime.localizedDdMm(dateTime);
  }

  static String miniDateOneLine(String dateTimeString){
    var dateString = dateTimeString.split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),int.parse(dateString[0]),int.parse(dateString[1]));
    return CustomizableDateTime.localizedDdMmOneLine(dateTime);
  }
}
