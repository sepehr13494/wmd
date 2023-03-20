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
  final int perPage = 10;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 64,
                    width: widget.widths[0],
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          widget.titles[0],
                          style: textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Builder(builder: (context) {
                      final visibleValues = widget.values.sublist(
                          0,
                          ((page * perPage) < widget.values.length
                              ? page * perPage
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
                            child: Builder(
                              builder: (context) {
                                final String insideValue = value[0];
                                return SizedBox(
                                  height: 64,
                                  width: widget.widths[0],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(
                                        insideValue,
                                        style: textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ],
              ),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: List.generate(widget.titles.length - 1, (index) {
                            return SizedBox(
                              height: 64,
                              width: widget.widths[index+1],
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    widget.titles[index+1],
                                    style: textTheme.titleSmall,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        Card(
                          margin: EdgeInsets.zero,
                          child: Builder(builder: (context) {
                            final visibleValues = widget.values.sublist(
                                0,
                                ((page * perPage) < widget.values.length
                                    ? page * perPage
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
                                    children: List.generate(value.length - 1, (index) {
                                      final String insideValue = value[index + 1];
                                      return SizedBox(
                                        height: 64,
                                        width: widget.widths[index+1],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          child: Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Text(
                                              insideValue,
                                              style: textTheme.bodySmall,
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
                ),
              ),
            ],
          ),
          widget.values.length < perPage ? const SizedBox() : ElevatedButton(
            onPressed: () {
              setState(() {
                if (page * perPage >= widget.values.length) {
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
              page * perPage >= widget.values.length
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
