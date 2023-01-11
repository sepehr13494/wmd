import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactReason {
  final String name;
  final String value;

  ContactReason({required this.name, required this.value});

  static List<Map<String, dynamic>> json(context) => [
        // {
        //   "value": "I want to learn more about available investment products",
        //   "name": "I want to learn more about available investment products"
        // },
        // {
        //   "value": "I have a general inquiry",
        //   "name": "I have a general inquiry"
        // },
        // {
        //   "value": "I need technical support",
        //   "name": "I need technical support"
        // },
        {
          "value": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_learnMore_value,
          "name": AppLocalizations.of(context)
              .common_submitEnquiryModal_reasons_learnMore_value
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
