import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_summary_params.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/asset_summary.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_valuation_performance_params.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/manager/performance_chart_cubit.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/widget/performance_chart.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/widget/performance_chart_v2.dart';
import 'package:wmd/injection_container.dart';
import '../manager/asset_summary_cubit.dart';
import '../../../valuation/presentation/widget/valuation_table.dart';

class AssetDetailPage extends StatefulWidget {
  final String assetId;
  final String type;
  const AssetDetailPage({Key? key, required this.assetId, required this.type})
      : super(key: key);

  @override
  AppState<AssetDetailPage> createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends AppState<AssetDetailPage> {
  late TimeFilterObj selectedTimeFilter =
      AppConstants.timeFilter(context).first;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final primaryColor = Theme.of(context).primaryColor;

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<AssetSummaryCubit>()
              ..getSummary(GetSummaryParams(
                  assetId: widget.assetId, days: selectedTimeFilter.value)),
          ),
          BlocProvider(
            create: (context) => sl<PerformanceChartCubit>()
              ..getValuationPerformance(GetValuationPerformanceParams(
                  days: selectedTimeFilter.value, id: widget.assetId)),
          )
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: const BaseAppBar(),
            body: BlocConsumer<PerformanceChartCubit, PerformanceChartState>(
                listener: BlocHelper.defaultBlocListener(
                  listener: (context, state) {},
                ),
                builder: (context, state) {
                  return Stack(
                    children: [
                      const LeafBackground(
                        opacity: 0.1,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            BlocConsumer<AssetSummaryCubit, AssetSummaryState>(
                                listener: BlocHelper.defaultBlocListener(
                                  listener: (context, state) {},
                                ),
                                builder: (context, state) {
                                  if (state is AssetLoaded) {
                                    return AsssetSummary(
                                      summary: state.assetSummaryEntity,
                                      days: selectedTimeFilter.value,
                                      assetId: widget.assetId,
                                      child: _buildHeader(
                                          Theme.of(context).textTheme,
                                          Theme.of(context).primaryColor,
                                          appLocalizations,
                                          context),
                                    );
                                  }
                                  return Padding(
                                    padding: EdgeInsets.all(
                                        responsiveHelper.bigger24Gap),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }),
                            if (state is PerformanceLoaded)
                              Padding(
                                padding:
                                    EdgeInsets.all(responsiveHelper.biggerGap),
                                child: PerformanceLineChart(
                                  values: state
                                      .performanceEntity.valuationHistory
                                      .map((e) => MapEntry(e.date, e.value))
                                      .toList(),
                                  days: selectedTimeFilter.value,
                                ),
                              ),
                            if (state is PerformanceLoaded)
                              Padding(
                                padding:
                                    EdgeInsets.all(responsiveHelper.biggerGap),
                                child: PerformanceLineChartV2(
                                  values: state
                                      .performanceEntity.valuationHistory
                                      .map((e) => MapEntry(e.date, e.value))
                                      .toList(),
                                  days: selectedTimeFilter.value,
                                ),
                              ),
                            SizedBox(height: responsiveHelper.biggerGap),
                            ValuationWidget(assetId: widget.assetId),
                            SizedBox(height: responsiveHelper.biggerGap),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          );
        }));
  }

  Row _buildHeader(TextTheme textTheme, Color primaryColor,
      AppLocalizations appLocalizations, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.assets_summary,
          style: textTheme.bodyLarge,
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 15,
              color: primaryColor,
            ),
            const SizedBox(width: 4),
            DropdownButtonHideUnderline(
              child: DropdownButton<TimeFilterObj>(
                items: AppConstants.timeFilter(context)
                    .map((e) => DropdownMenuItem<TimeFilterObj>(
                        value: e,
                        child: Text(
                          e.key,
                          style:
                              textTheme.bodyMedium!.apply(color: primaryColor),
                          // textTheme.bodyMedium!.toLinkStyle(context),
                        )))
                    .toList(),
                onChanged: ((value) async {
                  if (value != null) {
                    selectedTimeFilter = value;
                    setState(() {});

                    context
                        .read<PerformanceChartCubit>()
                        .getValuationPerformance(GetValuationPerformanceParams(
                            days: value.value, id: widget.assetId));

                    context.read<AssetSummaryCubit>().getSummary(
                        GetSummaryParams(
                            assetId: widget.assetId, days: value.value));

                    await AnalyticsUtils.triggerEvent(
                        action: AnalyticsUtils.changeDateIndividualAssetAction(
                            widget.assetId, value.value),
                        params: AnalyticsUtils.changeDateIndividualAssetEvent(
                            widget.assetId, value.value));
                  }
                }),
                value: selectedTimeFilter,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 15,
                  color: primaryColor,
                ),
                // style: textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
