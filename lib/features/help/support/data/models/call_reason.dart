import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CallReason {
  final String name;
  final String value;

  CallReason({required this.name, required this.value});

  static List<Map<String, dynamic>> json(context) => [
        {
          "value": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_learnMore_value,
          "name": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_learnMore_value,
        }
      ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory CallReason.fromJson(Map<String, dynamic> json) => CallReason(
        value: json["value"],
        name: json["name"],
      );

  static List<CallReason> callReasonList(context) =>
      json(context).map((e) => CallReason.fromJson(e)).toList();
}
