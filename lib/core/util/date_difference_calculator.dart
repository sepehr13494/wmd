class DateDifferenceCalculator {
  static List<int> calculateDifference(DateTime startDate, DateTime endDate) {
    Duration difference = endDate.difference(startDate);

    int years = difference.inDays ~/ 365;
    int months = 0;
    int days = 0;

    DateTime tempDate = DateTime(startDate.year + years, startDate.month, startDate.day);

    if (tempDate.isBefore(endDate)) {
      while (tempDate.isBefore(endDate)) {
        tempDate = DateTime(tempDate.year, tempDate.month + 1, tempDate.day);
        months++;
      }
      months--;
      tempDate = DateTime(tempDate.year, tempDate.month - 1, tempDate.day);
    }

    days = endDate.difference(tempDate).inDays;

    return [years, months, days];
  }
}
