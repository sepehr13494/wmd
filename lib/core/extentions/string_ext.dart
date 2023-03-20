extension StringExt on String {
  String addZeroToStart({int maxDigits = 2}) {
    if (length < maxDigits) {
      return "${"0" * (maxDigits - length)}$this";
    } else {
      return this;
    }
  }

  String stringifyError(String error) {
    return error
        .replaceAll('"', "")
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("[", "")
        .replaceAll("]", "");
  }

  num convertMoneyToInt() {
    String str = this;
    return num.parse(str.replaceAll(',', ''));
  }

  bool isDate() {
    try {
      DateTime.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }
}
