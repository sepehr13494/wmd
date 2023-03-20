import 'dart:async';

import 'package:countries_world_map/world/simple_world/src/simple_world_colors.dart';
import 'package:countries_world_map/world/simple_world/src/simple_world_map.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';

import '../../data/models/get_geographic_response.dart';
import '../../domain/entities/get_geographic_entity.dart';
import 'countries_json.dart';

class InsideWorldMapWidget extends StatefulWidget {
  final List<GetGeographicEntity> getGeographicEntity;

  const InsideWorldMapWidget({Key? key, required this.getGeographicEntity})
      : super(key: key);

  @override
  AppState<InsideWorldMapWidget> createState() => InsideWorldMapWidgetState();
}

class InsideWorldMapWidgetState extends AppState<InsideWorldMapWidget> {
  late String country = "";
  late String amount = "";
  late String percentage = "";
  late Offset offset = const Offset(0, 0);
  bool showTooltip = false;
  late Timer _timer;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return LayoutBuilder(builder: (context, snap) {
      return SizedBox(
        height: snap.maxWidth * 0.65,
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: snap.maxWidth * 0.92,
                // Actual widget from the Countries_world_map package.
                child: Builder(builder: (context) {
                  final asiaPercentage =
                      getPercentage("Asia", widget.getGeographicEntity);
                  final euroPercentage =
                      getPercentage("Europe", widget.getGeographicEntity);
                  final australiaPercentage =
                      getPercentage("Oceania", widget.getGeographicEntity);
                  final africaPercentage =
                      getPercentage("Africa", widget.getGeographicEntity);
                  final northAmericaPercentage = getPercentage(
                      "North America", widget.getGeographicEntity);
                  final southAmericaPercentage = getPercentage(
                      "South America", widget.getGeographicEntity);
                  final asiaColor = getColor(asiaPercentage);
                  final euroColor = getColor(euroPercentage);
                  final australiaColor = getColor(australiaPercentage);
                  final africaColor = getColor(africaPercentage);
                  final northAmericaColor = getColor(northAmericaPercentage);
                  final southAmericaColor = getColor(southAmericaPercentage);
                  return Stack(
                    alignment: Alignment(offset.dx, offset.dy),
                    children: [
                      SimpleWorldMap(
                        callback: (p0, p1) {
                          showTooltipFunc(p0, p1, widget.getGeographicEntity);
                        },
                        countryColors: SimpleWorldCountryColors(
                          iR: asiaColor,
                          rU: asiaColor,
                          aF: asiaColor,
                          aM: asiaColor,
                          aZ: asiaColor,
                          bH: asiaColor,
                          bD: asiaColor,
                          bT: asiaColor,
                          bN: asiaColor,
                          kH: asiaColor,
                          cN: asiaColor,
                          cX: asiaColor,
                          cC: asiaColor,
                          iO: asiaColor,
                          gE: asiaColor,
                          hK: asiaColor,
                          iN: asiaColor,
                          iD: asiaColor,
                          iQ: asiaColor,
                          iL: asiaColor,
                          jP: asiaColor,
                          jO: asiaColor,
                          kZ: asiaColor,
                          kW: asiaColor,
                          kG: asiaColor,
                          lA: asiaColor,
                          lB: asiaColor,
                          mO: asiaColor,
                          mY: asiaColor,
                          mV: asiaColor,
                          mN: asiaColor,
                          mM: asiaColor,
                          nP: asiaColor,
                          kP: asiaColor,
                          oM: asiaColor,
                          pK: asiaColor,
                          pS: asiaColor,
                          pH: asiaColor,
                          qA: asiaColor,
                          sA: asiaColor,
                          sG: asiaColor,
                          kR: asiaColor,
                          lK: asiaColor,
                          sY: asiaColor,
                          tW: asiaColor,
                          tJ: asiaColor,
                          tH: asiaColor,
                          tR: asiaColor,
                          tM: asiaColor,
                          aE: asiaColor,
                          uZ: asiaColor,
                          vN: asiaColor,
                          yE: asiaColor,
                          fR: euroColor,
                          aT: euroColor,
                          bE: euroColor,
                          bG: euroColor,
                          hR: euroColor,
                          cY: euroColor,
                          cZ: euroColor,
                          aQ: euroColor,
                          aX: euroColor,
                          bA: euroColor,
                          bV: euroColor,
                          bY: euroColor,
                          cH: euroColor,
                          fO: euroColor,
                          gG: euroColor,
                          gI: euroColor,
                          gS: euroColor,
                          hM: euroColor,
                          iM: euroColor,
                          jE: euroColor,
                          mC: euroColor,
                          mE: euroColor,
                          mF: euroColor,
                          mK: euroColor,
                          nO: euroColor,
                          pN: euroColor,
                          pT: euroColor,
                          rS: euroColor,
                          sJ: euroColor,
                          sM: euroColor,
                          tF: euroColor,
                          uA: euroColor,
                          vA: euroColor,
                          xK: euroColor,
                          dK: euroColor,
                          eE: euroColor,
                          fI: euroColor,
                          dE: euroColor,
                          gR: euroColor,
                          hU: euroColor,
                          iE: euroColor,
                          iT: euroColor,
                          lV: euroColor,
                          lT: euroColor,
                          lU: euroColor,
                          mT: euroColor,
                          nL: euroColor,
                          pL: euroColor,
                          rO: euroColor,
                          sK: euroColor,
                          sI: euroColor,
                          eS: euroColor,
                          sE: euroColor,
                          gB: euroColor,
                          aD: euroColor,
                          aL: euroColor,
                          dZ: africaColor,
                          aO: africaColor,
                          sH: africaColor,
                          bJ: africaColor,
                          bW: africaColor,
                          bF: africaColor,
                          bI: africaColor,
                          cM: africaColor,
                          cV: africaColor,
                          cF: africaColor,
                          tD: africaColor,
                          kM: africaColor,
                          cG: africaColor,
                          cD: africaColor,
                          dJ: africaColor,
                          eG: africaColor,
                          nE: africaColor,
                          gQ: africaColor,
                          eR: africaColor,
                          sZ: africaColor,
                          eT: africaColor,
                          gA: africaColor,
                          gM: africaColor,
                          gH: africaColor,
                          gN: africaColor,
                          gW: africaColor,
                          cI: africaColor,
                          kE: africaColor,
                          lS: africaColor,
                          lR: africaColor,
                          lY: africaColor,
                          mG: africaColor,
                          mW: africaColor,
                          mL: africaColor,
                          mR: africaColor,
                          mU: africaColor,
                          yT: africaColor,
                          mA: africaColor,
                          mZ: africaColor,
                          nA: africaColor,
                          nG: africaColor,
                          sT: africaColor,
                          rE: africaColor,
                          rW: africaColor,
                          sN: africaColor,
                          sC: africaColor,
                          sL: africaColor,
                          sO: africaColor,
                          zA: africaColor,
                          sS: africaColor,
                          sD: africaColor,
                          tZ: africaColor,
                          tG: africaColor,
                          tN: africaColor,
                          uG: africaColor,
                          zM: africaColor,
                          zW: africaColor,
                          aI: northAmericaColor,
                          aG: northAmericaColor,
                          aW: northAmericaColor,
                          bB: northAmericaColor,
                          mD: northAmericaColor,
                          bZ: northAmericaColor,
                          bM: northAmericaColor,
                          bQ: northAmericaColor,
                          vG: northAmericaColor,
                          cA: northAmericaColor,
                          kY: northAmericaColor,
                          cR: northAmericaColor,
                          cU: northAmericaColor,
                          cW: northAmericaColor,
                          eH: northAmericaColor,
                          dM: northAmericaColor,
                          dO: northAmericaColor,
                          sV: northAmericaColor,
                          gL: northAmericaColor,
                          gD: northAmericaColor,
                          gP: northAmericaColor,
                          lI: northAmericaColor,
                          gT: northAmericaColor,
                          hT: northAmericaColor,
                          hN: northAmericaColor,
                          iS: northAmericaColor,
                          jM: northAmericaColor,
                          mQ: northAmericaColor,
                          mX: northAmericaColor,
                          mS: northAmericaColor,
                          aN: northAmericaColor,
                          nI: northAmericaColor,
                          pA: northAmericaColor,
                          pR: northAmericaColor,
                          bL: northAmericaColor,
                          kN: northAmericaColor,
                          lC: northAmericaColor,
                          mP: northAmericaColor,
                          pM: northAmericaColor,
                          vC: northAmericaColor,
                          sX: northAmericaColor,
                          bS: northAmericaColor,
                          tT: northAmericaColor,
                          tC: northAmericaColor,
                          uS: northAmericaColor,
                          vI: northAmericaColor,
                          aR: southAmericaColor,
                          bO: southAmericaColor,
                          bR: southAmericaColor,
                          cL: southAmericaColor,
                          cO: southAmericaColor,
                          eC: southAmericaColor,
                          fK: southAmericaColor,
                          gF: southAmericaColor,
                          gY: southAmericaColor,
                          pY: southAmericaColor,
                          pE: southAmericaColor,
                          sR: southAmericaColor,
                          uY: southAmericaColor,
                          vE: southAmericaColor,
                          aU: australiaColor,
                          aS: australiaColor,
                          nZ: australiaColor,
                          cK: australiaColor,
                          tL: australiaColor,
                          fM: australiaColor,
                          fJ: australiaColor,
                          pF: australiaColor,
                          gU: australiaColor,
                          kI: australiaColor,
                          mH: australiaColor,
                          uM: australiaColor,
                          nR: australiaColor,
                          nC: australiaColor,
                          nU: australiaColor,
                          nF: australiaColor,
                          pW: australiaColor,
                          pG: australiaColor,
                          wS: australiaColor,
                          sB: australiaColor,
                          tK: australiaColor,
                          tO: australiaColor,
                          tV: australiaColor,
                          vU: australiaColor,
                          wF: australiaColor,
                        ),
                      ),
                      showTooltip
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.anotherCardColorForDarkTheme,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(country,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        amount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      ),
                                      const SizedBox(width: 24),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          percentage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .apply(
                                                  color: AppColors.chartColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox()
                    ],
                  );
                }),
              ),
              // Creates 8% from right side so the map looks more centered.
              Container(width: snap.maxWidth * 0.08),
            ],
          ),
        ),
      );
    });
  }

  static Color getColor(double percentage) {
    if (percentage == 0) {
      return AppColors.continentEmptyColor;
    } else if (percentage < 0.1) {
      return AppColors.continentLowColor;
    } else if (percentage < 0.3) {
      return AppColors.continentMiddleColor;
    } else if (percentage < 0.5) {
      return AppColors.continentHighColor;
    } else {
      return AppColors.continentFullColor;
    }
  }

  static Color getColorByList(
      String continent, List<GetGeographicEntity> list) {
    return getColor(getPercentage(continent, list));
  }

  static double getPercentage(
      String name, List<GetGeographicEntity> getGeographicEntity) {
    return getGeographicEntity
            .firstWhere((element) => element.continent == name,
                orElse: () => GetGeographicResponse(
                    percentage: 0, amount: 0, continent: name))
            .percentage /
        100;
  }

  void showTooltipFunc(String p0, TapUpDetails p1,
      List<GetGeographicEntity> getGeographicEntity) {
    setState(() {
      final Map<String, String> countries = CountriesJson.json;
      String continent = countries[p0] ?? "";
      country = continent;
      final GetGeographicEntity entity = getGeographicEntity
          .firstWhere((element) => element.continent == continent);
      amount = entity.amount.convertMoney(addDollar: true);
      percentage = "${entity.percentage.toStringAsFixed(1)} %";
      switch (continent) {
        case "Asia":
          offset = const Offset(0.7, -0.5);
          break;
        case "Europe":
          offset = const Offset(0.0, -0.5);
          break;
        case "Africa":
          offset = const Offset(0.0, 0.3);
          break;
        case "North America":
          offset = const Offset(-0.6, -0.5);
          break;
        case "South America":
          offset = const Offset(-0.6, 0.5);
          break;
        case "Oceania":
          offset = const Offset(1, 0.8);
          break;
        default:
          offset = const Offset(0.0, 0.0);
      }
      showTooltip = true;
    });
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        showTooltip = false;
      });
    });
  }
}
