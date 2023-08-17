import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Currency extends Equatable {
  final String symbol;
  final String name;

  const Currency({
    required this.symbol,
    required this.name,
  });

  static Currency getCurrencyFromString(
      String currencyCode, BuildContext context) {
    return Currency.getCurrencyList(context).firstWhere(
      (element) => element.symbol == currencyCode,
      orElse: () => const Currency(symbol: "not found", name: "not found"),
    );
  }

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        symbol: json["value"],
        name: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": symbol,
        "label": name,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [
        symbol,
        name,
      ];

  static List<Currency> getCurrencyList(BuildContext context) =>
      json(context).map((e) => Currency.fromJson(e)).toList();

  static List<Map<String, String>> json(context) {
    final appLocalizations = AppLocalizations.of(context);
    return [
      {"value": "USD", "label": appLocalizations.currencies_USD},
      {"value": "ZWD", "label": appLocalizations.currencies_ZWD},
      {"value": "AED", "label": appLocalizations.currencies_AED},
      {"value": "AFN", "label": appLocalizations.currencies_AFN},
      {"value": "ALL", "label": appLocalizations.currencies_ALL},
      {"value": "ANG", "label": appLocalizations.currencies_ANG},
      {"value": "ARS", "label": appLocalizations.currencies_ARS},
      {"value": "AUD", "label": appLocalizations.currencies_AUD},
      {"value": "AWG", "label": appLocalizations.currencies_AWG},
      {"value": "AZN", "label": appLocalizations.currencies_AZN},
      {"value": "BAM", "label": appLocalizations.currencies_BAM},
      {"value": "BBD", "label": appLocalizations.currencies_BBD},
      {"value": "BGN", "label": appLocalizations.currencies_BGN},
      {"value": "BMD", "label": appLocalizations.currencies_BMD},
      {"value": "BND", "label": appLocalizations.currencies_BND},
      {"value": "BOB", "label": appLocalizations.currencies_BOB},
      {"value": "BRL", "label": appLocalizations.currencies_BRL},
      {"value": "BSD", "label": appLocalizations.currencies_BSD},
      {"value": "BWP", "label": appLocalizations.currencies_BWP},
      {"value": "BYN", "label": appLocalizations.currencies_BYN},
      {"value": "BZD", "label": appLocalizations.currencies_BZD},
      {"value": "CAD", "label": appLocalizations.currencies_CAD},
      {"value": "CHF", "label": appLocalizations.currencies_CHF},
      {"value": "CLP", "label": appLocalizations.currencies_CLP},
      {"value": "CNY", "label": appLocalizations.currencies_CNY},
      {"value": "COP", "label": appLocalizations.currencies_COP},
      {"value": "CRC", "label": appLocalizations.currencies_CRC},
      {"value": "CUP", "label": appLocalizations.currencies_CUP},
      {"value": "CZK", "label": appLocalizations.currencies_CZK},
      {"value": "DKK", "label": appLocalizations.currencies_DKK},
      {"value": "DOP", "label": appLocalizations.currencies_DOP},
      {"value": "EGP", "label": appLocalizations.currencies_EGP},
      {"value": "EUR", "label": appLocalizations.currencies_EUR},
      {"value": "FJD", "label": appLocalizations.currencies_FJD},
      {"value": "FKP", "label": appLocalizations.currencies_FKP},
      {"value": "GBP", "label": appLocalizations.currencies_GBP},
      {"value": "GGP", "label": appLocalizations.currencies_GGP},
      {"value": "GHS", "label": appLocalizations.currencies_GHS},
      {"value": "GIP", "label": appLocalizations.currencies_GIP},
      {"value": "GTQ", "label": appLocalizations.currencies_GTQ},
      {"value": "GYD", "label": appLocalizations.currencies_GYD},
      {"value": "HKD", "label": appLocalizations.currencies_HKD},
      {"value": "HNL", "label": appLocalizations.currencies_HNL},
      {"value": "HRK", "label": appLocalizations.currencies_HRK},
      {"value": "HUF", "label": appLocalizations.currencies_HUF},
      {"value": "IDR", "label": appLocalizations.currencies_IDR},
      {"value": "ILS", "label": appLocalizations.currencies_ILS},
      {"value": "IMP", "label": appLocalizations.currencies_IMP},
      {"value": "INR", "label": appLocalizations.currencies_INR},
      {"value": "IRR", "label": appLocalizations.currencies_IRR},
      {"value": "ISK", "label": appLocalizations.currencies_ISK},
      {"value": "JEP", "label": appLocalizations.currencies_JEP},
      {"value": "JMD", "label": appLocalizations.currencies_JMD},
      {"value": "JPY", "label": appLocalizations.currencies_JPY},
      {"value": "KGS", "label": appLocalizations.currencies_KGS},
      {"value": "KHR", "label": appLocalizations.currencies_KHR},
      {"value": "KPW", "label": appLocalizations.currencies_KPW},
      {"value": "KRW", "label": appLocalizations.currencies_KRW},
      {"value": "KYD", "label": appLocalizations.currencies_KYD},
      {"value": "KZT", "label": appLocalizations.currencies_KZT},
      {"value": "LAK", "label": appLocalizations.currencies_LAK},
      {"value": "LBP", "label": appLocalizations.currencies_LBP},
      {"value": "LKR", "label": appLocalizations.currencies_LKR},
      {"value": "LRD", "label": appLocalizations.currencies_LRD},
      {"value": "MKD", "label": appLocalizations.currencies_MKD},
      {"value": "MNT", "label": appLocalizations.currencies_MNT},
      {"value": "MUR", "label": appLocalizations.currencies_MUR},
      {"value": "MXN", "label": appLocalizations.currencies_MXN},
      {"value": "MYR", "label": appLocalizations.currencies_MYR},
      {"value": "MZN", "label": appLocalizations.currencies_MZN},
      {"value": "NAD", "label": appLocalizations.currencies_NAD},
      {"value": "NGN", "label": appLocalizations.currencies_NGN},
      {"value": "NIO", "label": appLocalizations.currencies_NIO},
      {"value": "NOK", "label": appLocalizations.currencies_NOK},
      {"value": "NPR", "label": appLocalizations.currencies_NPR},
      {"value": "NZD", "label": appLocalizations.currencies_NZD},
      {"value": "OMR", "label": appLocalizations.currencies_OMR},
      {"value": "PAB", "label": appLocalizations.currencies_PAB},
      {"value": "PEN", "label": appLocalizations.currencies_PEN},
      {"value": "PHP", "label": appLocalizations.currencies_PHP},
      {"value": "PKR", "label": appLocalizations.currencies_PKR},
      {"value": "PLN", "label": appLocalizations.currencies_PLN},
      {"value": "PYG", "label": appLocalizations.currencies_PYG},
      {"value": "QAR", "label": appLocalizations.currencies_QAR},
      {"value": "RON", "label": appLocalizations.currencies_RON},
      {"value": "RSD", "label": appLocalizations.currencies_RSD},
      {"value": "RUB", "label": appLocalizations.currencies_RUB},
      {"value": "SAR", "label": appLocalizations.currencies_SAR},
      {"value": "SBD", "label": appLocalizations.currencies_SBD},
      {"value": "SCR", "label": appLocalizations.currencies_SCR},
      {"value": "SEK", "label": appLocalizations.currencies_SEK},
      {"value": "SGD", "label": appLocalizations.currencies_SGD},
      {"value": "SHP", "label": appLocalizations.currencies_SHP},
      {"value": "SOS", "label": appLocalizations.currencies_SOS},
      {"value": "SRD", "label": appLocalizations.currencies_SRD},
      {"value": "SVC", "label": appLocalizations.currencies_SVC},
      {"value": "SYP", "label": appLocalizations.currencies_SYP},
      {"value": "THB", "label": appLocalizations.currencies_THB},
      {"value": "TRY", "label": appLocalizations.currencies_TRY},
      {"value": "TTD", "label": appLocalizations.currencies_TTD},
      {"value": "TVD", "label": appLocalizations.currencies_TVD},
      {"value": "TWD", "label": appLocalizations.currencies_TWD},
      {"value": "UAH", "label": appLocalizations.currencies_UAH},
      {"value": "UYU", "label": appLocalizations.currencies_UYU},
      {"value": "UZS", "label": appLocalizations.currencies_UZS},
      {"value": "VEF", "label": appLocalizations.currencies_VEF},
      {"value": "VND", "label": appLocalizations.currencies_VND},
      {"value": "XCD", "label": appLocalizations.currencies_XCD},
      {"value": "YER", "label": appLocalizations.currencies_YER},
      {"value": "ZAR", "label": appLocalizations.currencies_ZAR},
    ];
  }
}
