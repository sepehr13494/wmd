import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import '../models/each_asset_model.dart';

class InsidePieChart extends StatefulWidget {
  final List<EachAssetViewModel> eachAssetViewModels;
  const InsidePieChart({super.key, required this.eachAssetViewModels});

  @override
  AppState<StatefulWidget> createState() => InsidePieChartState();
}

class InsidePieChartState extends AppState<InsidePieChart> {
  int touchedIndex = -1;

  Timer? timer;

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return LayoutBuilder(builder: (context, snap) {
      final double height = snap.maxWidth * 0.65;
      final inside = height / 5;
      return SizedBox(
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.eachAssetViewModels.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: PieChart(PieChartData(sections: [
                  PieChartSectionData(
                    color: Colors.white12,
                    value: 100,
                    title: '',
                    radius: (height - inside) / 4,
                  )
                ])),
              ),
            PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback:
                      (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        return;
                      }
                      touchedIndex = pieTouchResponse
                          .touchedSection!.touchedSectionIndex;
                      if (timer != null) {
                        timer!.cancel();
                      }
                      timer = Timer(const Duration(seconds: 2), () {
                        setState(() {
                          touchedIndex = -1;
                        });
                      });
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: inside,
                sections: showingSections(
                    (height - inside) / 4,
                    widget.eachAssetViewModels),
              ),
            ),
            touchedIndex != -1
                ? Builder(builder: (context) {
              return _buildTooltip(widget.eachAssetViewModels[touchedIndex], context, appLocalizations);
            })
                : const SizedBox()
          ],
        ),
      );
    });
  }

  List<PieChartSectionData> showingSections(
      double outside, List<EachAssetViewModel> eachAssetViewModels) {
    return List.generate(eachAssetViewModels.length, (index) {
      final pieStrokeWidth = outside;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? pieStrokeWidth + 10 : pieStrokeWidth;
      EachAssetViewModel eachAsset = eachAssetViewModels[index];
      return PieChartSectionData(
        color: eachAsset.color ?? Colors.pink,
        value: eachAsset.value,
        title: '',
        radius: radius,
      );
    });
  }
}

Widget _buildTooltip(EachAssetViewModel eachAssetViewModel,context,appLocalizations){
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.anotherCardColorForDarkTheme,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            eachAssetViewModel.name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrivacyBlurWidget(
              child: Text(
                eachAssetViewModel.value
                    .convertMoney(addDollar: true),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!,
              ),
            ),
            const SizedBox(width: 24),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                "${eachAssetViewModel.percentage} %",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(
                    color:
                    AppColors.chartColor),
              ),
            )
          ],
        ),
      ],
    ),
  );

}

Widget _buildEmptyChart(
    AppLocalizations appLocalizations, TextTheme textTheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appLocalizations.common_emptyText_title,
          style: textTheme.bodyLarge,
        ),
        Text(
          appLocalizations.common_emptyText_assetClassDescription,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall,
        ),
      ],
    ),
  );
}
