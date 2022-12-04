import 'package:wmd/core/models/radio_button_options.dart';

class RadioLiabilityType {
  final RadioButtonOptions<bool> list;

  RadioLiabilityType({required this.list});

  static const json = [
    RadioButtonOptions(label: "Yes", value: true),
    RadioButtonOptions(label: "No", value: false),
  ];

  static const radioLiabilityList = json;
}
