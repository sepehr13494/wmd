import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/models/performance_value_obj.dart';

class PerformanceBaseTable extends StatefulWidget {
  final List<String> titles;
  final List<double> widths;
  final List<List<PerformanceValueObj>> values;

  const PerformanceBaseTable({
    Key? key,
    required this.titles,
    required this.widths,
    required this.values,
  }) : super(key: key);

  @override
  AppState<PerformanceBaseTable> createState() => _PerformanceBaseTableState();
}

class _PerformanceBaseTableState extends AppState<PerformanceBaseTable> {
  late int page = 1;
  final int perPage = 100;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return LayoutBuilder(builder: (context, snap) {
      double maxWidth = snap.maxWidth - 40 - widget.widths[0];
      double multipleBy = 1;
      final double othersSum = widget.widths
          .sublist(1, widget.widths.length)
          .reduce((a, b) => a + b);
      if (othersSum < maxWidth) {
        multipleBy = maxWidth / othersSum;
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: widget.values.isEmpty
            ? Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(widget.titles.length, (index) {
                        return SizedBox(
                          height: 64,
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
                  ),
                  Card(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appLocalizations.common_emptyText_pnlEmptyMessage,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium!
                              .apply(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Column(
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
                                children: List.generate(visibleValues.length,
                                    (index) {
                                  final List<PerformanceValueObj> value =
                                      visibleValues[index];
                                  return Container(
                                    color: index.isEven
                                        ? Theme.of(context).cardColor
                                        : (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppColors
                                                .darkCardColorForDarkTheme
                                            : AppColors
                                                .darkCardColorForLightTheme),
                                    child: Builder(builder: (context) {
                                      final PerformanceValueObj insideValue =
                                          value[0];
                                      return SizedBox(
                                        height: 64,
                                        width: widget.widths[0],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: PrivacyBlurWidget(
                                              blur: insideValue.shouldBlur,
                                              child: Text(
                                                insideValue.value,
                                                style: textTheme.bodySmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                }),
                              );
                            }),
                          ),
                        ],
                      ),
                      Builder(builder: (context) {
                        final ScrollController scrollController =
                            ScrollController();
                        return Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            trackVisibility: true,
                            controller: scrollController,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  Row(
                                    children: List.generate(
                                        widget.titles.length - 1, (index) {
                                      return SizedBox(
                                        height: 64,
                                        width: widget.widths[index + 1] *
                                            multipleBy,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              widget.titles[index + 1],
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
                                      final visibleValues = widget.values
                                          .sublist(
                                              0,
                                              ((page * perPage) <
                                                      widget.values.length
                                                  ? page * perPage
                                                  : widget.values.length));
                                      return Column(
                                        children: List.generate(
                                            visibleValues.length, (index) {
                                          final List<PerformanceValueObj>
                                              value = visibleValues[index];
                                          return Container(
                                            color: index.isEven
                                                ? Theme.of(context).cardColor
                                                : (Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? AppColors
                                                        .darkCardColorForDarkTheme
                                                    : AppColors
                                                        .darkCardColorForLightTheme),
                                            child: Row(
                                              children: List.generate(
                                                  value.length - 1, (index) {
                                                final PerformanceValueObj
                                                    insideValue =
                                                    value[index + 1];
                                                return SizedBox(
                                                  height: 64,
                                                  width:
                                                      widget.widths[index + 1] *
                                                          multipleBy,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .centerStart,
                                                      child:
                                                          PrivacyBlurWidgetClickable(
                                                        blur: insideValue
                                                            .shouldBlur,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .centerStart,
                                                                child: Text(
                                                                  insideValue
                                                                      .value,
                                                                  style: textTheme
                                                                      .bodySmall,
                                                                ),
                                                              ),
                                                            ),
                                                            if (insideValue
                                                                .showTooltip)
                                                              Tooltip(
                                                                showDuration:
                                                                    const Duration(
                                                                        seconds:
                                                                            5),
                                                                triggerMode:
                                                                    TooltipTriggerMode
                                                                        .tap,
                                                                message: AppLocalizations.of(
                                                                        context)
                                                                    .assets_tooltips_percentageAbsurd,
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                  child:
                                                                      InfoIcon(),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
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
                        );
                      }),
                    ],
                  ),
                  widget.values.length < perPage
                      ? const SizedBox()
                      : ElevatedButton(
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
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.cardColor),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.maxFinite, 48)),
                            side: MaterialStateProperty.all(BorderSide.none),
                          ),
                          child: Text(
                            page * perPage >= widget.values.length
                                ? appLocalizations.common_button_viewLess
                                : appLocalizations.common_button_viewMore,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                ],
              ),
      );
    });
  }
}
