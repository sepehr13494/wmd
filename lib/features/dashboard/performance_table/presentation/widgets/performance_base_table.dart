import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';

class PerformanceBaseTable extends AppStatelessWidget {
  final List<String> titles;
  final List<double> widths;
  final List<List<String>> values;

  const PerformanceBaseTable(
      {Key? key,
      required this.titles,
      required this.widths,
      required this.values})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: List.generate(titles.length, (index) {
              return SizedBox(
                width: widths[index],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    titles[index],
                    style: textTheme.titleSmall,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Column(
            children: List.generate(values.length, (index) {
              final List<String> value = values[index];
              return Row(
                children: List.generate(value.length, (index) {
                  final String insideValue = value[index];
                  return Container(
                    color: index.isOdd
                        ? Theme.of(context).cardColor
                        : (Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkCardColorForDarkTheme
                            : AppColors.darkCardColorForLightTheme),
                    width: widths[index],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        insideValue,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  );
                }),
              );
            }),
          )
        ],
      ),
    );
  }
}
