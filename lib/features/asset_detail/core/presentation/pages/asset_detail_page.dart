import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/asset_summary.dart';
import 'package:wmd/features/asset_detail/listed_asset/domain/entity/listed_asset_entity.dart';
import 'package:wmd/features/asset_detail/private_debt/domain/entity/private_debt_entity.dart';
import 'package:wmd/features/asset_detail/private_equity/domain/entity/private_equity_entity.dart';
import 'package:wmd/features/asset_detail/real_estate/domain/entity/real_estate_entity.dart';
import 'package:wmd/features/asset_detail/real_estate/presentation/page/real_estate_page.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_valuation_performance_params.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/manager/performance_chart_cubit.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/widget/performance_chart.dart';
import 'package:wmd/injection_container.dart';
import '../manager/asset_detail_cubit.dart';
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
  static const _timeFilter = [
    // MapEntry<String, int>("All times", 0),
    MapEntry<String, int>("7 days", 7),
    MapEntry<String, int>("30 days", 30),
  ];

  MapEntry<String, int> selectedTimeFilter = _timeFilter.first;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: Stack(
        children: [
          const LeafBackground(
            opacity: 0.1,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => sl<PerformanceChartCubit>()
                    ..getValuationPerformance(GetValuationPerformanceParams(
                        days: selectedTimeFilter.value, id: widget.assetId)),
                  child: BlocConsumer<PerformanceChartCubit,
                          PerformanceChartState>(
                      listener: BlocHelper.defaultBlocListener(
                        listener: (context, state) {},
                      ),
                      builder: (context, state) {
                        if (state is PerformanceLoaded) {
                          return Column(
                            children: [
                              _buildSummaryCard(
                                  responsiveHelper,
                                  selectedTimeFilter.value,
                                  state.performanceEntity.netChange),
                              Padding(
                                padding:
                                    EdgeInsets.all(responsiveHelper.biggerGap),
                                child: PerformanceLineChart(
                                    values: state
                                        .performanceEntity.valuationHistory
                                        .map((e) => MapEntry(e.date, e.value))
                                        .toList()),
                              ),
                            ],
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.all(
                              ResponsiveHelper(context: context).bigger16Gap),
                          child: const CircularProgressIndicator(),
                        );
                      }),
                ),
                SizedBox(height: responsiveHelper.biggerGap),
                ValuationWidget(assetId: widget.assetId),
                SizedBox(height: responsiveHelper.biggerGap),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildHeader(TextTheme textTheme, Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 15,
              color: primaryColor,
            ),
            const SizedBox(width: 4),
            DropdownButton<MapEntry<String, int>>(
              items: _timeFilter
                  .map((e) => DropdownMenuItem<MapEntry<String, int>>(
                      value: e,
                      child: Text(
                        e.key,
                        style: textTheme.bodyMedium!.apply(color: primaryColor),
                        // textTheme.bodyMedium!.toLinkStyle(context),
                      )))
                  .toList(),
              onChanged: ((value) {
                if (value != null) {
                  setState(() {
                    selectedTimeFilter = value;
                  });
                  sl<PerformanceChartCubit>().getValuationPerformance(
                      GetValuationPerformanceParams(
                          days: value.value, id: widget.assetId));
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
          ],
        ),
      ],
    );
  }

  BlocProvider<AssetDetailCubit> _buildSummaryCard(
      ResponsiveHelper responsiveHelper, int days, double netChange) {
    return BlocProvider(
      create: (context) => sl<AssetDetailCubit>()
        ..getDetail(
            GetDetailParams(type: widget.type, assetId: widget.assetId)),
      child: BlocConsumer<AssetDetailCubit, AssetDetailState>(
          listener: BlocHelper.defaultBlocListener(
            listener: (context, state) {},
          ),
          builder: (context, state) {
            if (state is AssetLoaded) {
              switch (widget.type) {
                case AssetTypes.bankAccount:
                  final item = state.assetDetailEntity as BankAccountEntity;
                  return AsssetSummary(
                    title: item.bankName,
                    currencyCode: item.currencyCode,
                    holdings: item.holdings,
                    days: days,
                    netChange: netChange,
                    portfolioContribution: item.portfolioContribution,
                    asOfDate: item.asOfDate,
                    child: _buildHeader(
                      Theme.of(context).textTheme,
                      Theme.of(context).primaryColor,
                    ),
                  );
                case AssetTypes.realEstate:
                  return RealEstateDetailPage(
                      realEstateEntity:
                          state.assetDetailEntity as RealEstateEntity);
                case AssetTypes.listedAsset:
                  final item = state.assetDetailEntity as ListedAssetEntity;
                  return AsssetSummary(
                    title: item.securityName,
                    subTitle: item.brokerName,
                    currencyCode: item.currencyCode,
                    holdings: item.holdings,
                    days: days,
                    netChange: netChange,
                    portfolioContribution: item.portfolioContribution,
                    asOfDate: item.asOfDate,
                    child: _buildHeader(
                      Theme.of(context).textTheme,
                      Theme.of(context).primaryColor,
                    ),
                  );

                case AssetTypes.privateDebt:
                  final item = state.assetDetailEntity as PrivateDebtEntity;
                  return AsssetSummary(
                    title: item.investmentName,
                    subTitle: item.wealthManager,
                    currencyCode: item.currencyCode,
                    holdings: item.holdings,
                    days: days,
                    netChange: netChange,
                    portfolioContribution: item.portfolioContribution,
                    asOfDate: item.asOfDate,
                    child: _buildHeader(
                      Theme.of(context).textTheme,
                      Theme.of(context).primaryColor,
                    ),
                  );
                case AssetTypes.privateEquity:
                  final item = state.assetDetailEntity as PrivateEquityEntity;
                  return AsssetSummary(
                    title: item.investmentName,
                    subTitle: item.wealthManager,
                    currencyCode: item.currencyCode,
                    holdings: item.holdings,
                    days: days,
                    netChange: netChange,
                    portfolioContribution: item.portfolioContribution,
                    asOfDate: item.asOfDate,
                    child: _buildHeader(
                      Theme.of(context).textTheme,
                      Theme.of(context).primaryColor,
                    ),
                  );
                default:
                  return Text(state.assetDetailEntity.toString());
              }
            }
            return Padding(
              padding: EdgeInsets.all(responsiveHelper.bigger24Gap),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
