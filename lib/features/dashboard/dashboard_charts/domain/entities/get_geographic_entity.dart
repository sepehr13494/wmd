import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetGeographicEntity extends Equatable {
  const GetGeographicEntity({
    required this.continent,
    required this.amount,
    required this.percentage,
  });

  final String continent;
  final double amount;
  final double percentage;

  Map<String, dynamic> toJson() => {
        "continent": continent,
        "amount": amount,
        "percentage": percentage,
      };

  String getContinentName(BuildContext context) {
    return getContinentNameLocale(context, continent);
  }

  @override
  List<Object?> get props => [
        continent,
        amount,
        percentage,
      ];
}

String getContinentNameLocale(BuildContext context, String name) {
  String targetCountry = name;

  switch (name) {
    case "Asia":
      targetCountry = AppLocalizations.of(context).assets_geography_Asia;
      break;
    case "North America":
      targetCountry =
          AppLocalizations.of(context).assets_geography_NorthAmerica;
      break;
    case "Europe":
      targetCountry = AppLocalizations.of(context).assets_geography_Europe;
      break;
    case "Africa":
      targetCountry = AppLocalizations.of(context).assets_geography_Africa;
      break;
    case "South America":
      targetCountry =
          AppLocalizations.of(context).assets_geography_SouthAmerica;
      break;
    case "Australia":
      targetCountry = AppLocalizations.of(context).assets_geography_Australia;
      break;
    case "Oceania":
      targetCountry = AppLocalizations.of(context).assets_geography_Oceania;
      break;
    case "Other":
      targetCountry = AppLocalizations.of(context).assets_geography_Other;
      break;
    case "Other / Not Applicable":
      targetCountry =
          AppLocalizations.of(context).assets_geography_OtherNotApplicable;
      break;
    default:
  }
  return targetCountry;
}
