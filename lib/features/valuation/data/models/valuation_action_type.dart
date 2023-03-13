import 'package:wmd/core/models/radio_button_options.dart';

class ValuationActionType {
  final RadioButtonOptions<bool> list;

  ValuationActionType({required this.list});

  static const json = [
    RadioButtonOptions(label: "Buy", value: "Buy"),
    RadioButtonOptions(label: "Sell", value: "Sell"),
    RadioButtonOptions(
        label: "Income / Capital distribution",
        value: "Income / Capital distribution"),
  ];

  static const valuationActionTypeList = json;
}
