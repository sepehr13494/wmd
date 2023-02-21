import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactReason {
  final String name;
  final String value;

  ContactReason({required this.name, required this.value});

  static List<Map<String, dynamic>> json(context) => [
        {
          "value": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_learnMore_value,
          "name": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_learnMore_label
        },
        {
          "value": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_discuss_value,
          "name": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_discuss_label
        },
        {
          "value": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_custodianBank_value,
          "name": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_custodianBank_label
        },
      ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory ContactReason.fromJson(Map<String, dynamic> json) => ContactReason(
        value: json["value"],
        name: json["name"],
      );

  static List<ContactReason> contactReasonList(context) =>
      json(context).map((e) => ContactReason.fromJson(e)).toList();
}
