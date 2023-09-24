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
      {"value": "BHD", "label": appLocalizations.currencies_BHD},
      {"value": "SAR", "label": appLocalizations.currencies_SAR},
      {"value": "KWD", "label": appLocalizations.currencies_KWD},
      {"value": "QAR", "label": appLocalizations.currencies_QAR},
      {"value": "AED", "label": appLocalizations.currencies_AED},
      {"value": "CHF", "label": appLocalizations.currencies_CHF},
      {"value": "EUR", "label": appLocalizations.currencies_EUR},
      {"value": "GBP", "label": appLocalizations.currencies_GBP},
    ];
  }
}
