import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';

class PerformanceBaseTable extends StatefulWidget {
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
  AppState<PerformanceBaseTable> createState() => _PerformanceBaseTableState();
}

class _PerformanceBaseTableState extends AppState<PerformanceBaseTable> {
  late int page = 1;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: List.generate(widget.titles.length, (index) {
                    return SizedBox(
                      width: widget.widths[index],
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            widget.titles[index],
                            style: textTheme.titleSmall,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Builder(builder: (context) {
                    final visibleValues = widget.values.sublist(
                        0,
                        ((page * 5) < widget.values.length
                            ? page * 5
                            : widget.values.length));
                    return Column(
                      children: List.generate(visibleValues.length, (index) {
                        final List<String> value = visibleValues[index];
                        return Container(
                          color: index.isEven
                              ? Theme.of(context).cardColor
                              : (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkCardColorForDarkTheme
                                  : AppColors.darkCardColorForLightTheme),
                          child: Row(
                            children: List.generate(value.length, (index) {
                              final String insideValue = value[index];
                              return SizedBox(
                                height: 64,
                                width: widget.widths[index],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      insideValue,
                                      style: textTheme.bodyMedium!.apply(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
          ),
          widget.values.length < 5 ? const SizedBox() : ElevatedButton(
            onPressed: () {
              setState(() {
                if (page * 5 >= widget.values.length) {
                  page = 1;
                } else {
                  page++;
                }
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.cardColor),
              minimumSize:
              MaterialStateProperty.all(const Size(double.maxFinite, 48)),
              side: MaterialStateProperty.all(BorderSide.none),
            ),
            child: Text(
              page * 5 >= widget.values.length
                  ? appLocalizations.common_button_viewLess
                  : appLocalizations.common_button_viewMore,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
