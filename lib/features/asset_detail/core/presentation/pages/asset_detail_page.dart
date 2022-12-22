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
import 'package:wmd/features/asset_detail/listed_asset/domain/entity/listed_asset_entity.dart';
import 'package:wmd/features/asset_detail/listed_asset/presentation/page/listed_asset_page.dart';
import 'package:wmd/features/asset_detail/private_debt/domain/entity/private_debt_entity.dart';
import 'package:wmd/features/asset_detail/private_debt/presentation/page/private_debt_page.dart';
import 'package:wmd/features/asset_detail/private_equity/domain/entity/private_equity_entity.dart';
import 'package:wmd/features/asset_detail/private_equity/presentation/page/private_equity_page.dart';
import 'package:wmd/features/asset_detail/real_estate/domain/entity/real_estate_entity.dart';
import 'package:wmd/features/asset_detail/real_estate/presentation/page/real_estate_page.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/widget/performance_chart.dart';
import 'package:wmd/injection_container.dart';
import '../manager/asset_detail_cubit.dart';
import '../../../bank_account/presentation/page/bank_account_page.dart';
import '../../../valuation/presentation/widget/valuation_table.dart';

class AssetDetailPage extends AppStatelessWidget {
  final String assetId;
  final String type;
  const AssetDetailPage({Key? key, required this.assetId, required this.type})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset details'),
      ),
      body: Stack(
        children: [
          const LeafBackground(
            opacity: 0.1,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SummaryTitle(),
                _buildSummaryCard(responsiveHelper),
                Padding(
                  padding: EdgeInsets.all(responsiveHelper.biggerGap),
                  child: PerformanceChart(id: assetId),
                ),
                SizedBox(height: responsiveHelper.biggerGap),
                ValuationWidget(assetId: assetId),
                SizedBox(height: responsiveHelper.biggerGap),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BlocProvider<AssetDetailCubit> _buildSummaryCard(
      ResponsiveHelper responsiveHelper) {
    return BlocProvider(
      create: (context) => sl<AssetDetailCubit>()
        ..getDetail(GetDetailParams(type: type, assetId: assetId)),
      child: BlocConsumer<AssetDetailCubit, AssetDetailState>(
          listener: BlocHelper.defaultBlocListener(
            listener: (context, state) {},
          ),
          builder: (context, state) {
            if (state is AssetLoaded) {
              switch (type) {
                case AssetTypes.bankAccount:
                  return BankAccountDetailPage(
                      bankAccountEntity:
                          state.assetDetailEntity as BankAccountEntity);
                case AssetTypes.realEstate:
                  return RealEstateDetailPage(
                      realEstateEntity:
                          state.assetDetailEntity as RealEstateEntity);
                case AssetTypes.listedAsset:
                  return ListedAssetDetailPage(
                      listedAssetEntity:
                          state.assetDetailEntity as ListedAssetEntity);
                case AssetTypes.privateDebt:
                  return PrivateDebtDetailPage(
                      privateDebtEntity:
                          state.assetDetailEntity as PrivateDebtEntity);
                case AssetTypes.privateEquity:
                  return PrivateEquityDetailPage(
                      privateEquityEntity:
                          state.assetDetailEntity as PrivateEquityEntity);
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

class SummaryTitle extends StatefulWidget {
  const SummaryTitle({
    Key? key,
  }) : super(key: key);

  @override
  AppState<SummaryTitle> createState() => _SummaryTitleState();
}

class _SummaryTitleState extends AppState<SummaryTitle> {
  static const _timeFilter = [
    // MapEntry<String, int>("All times", 0),
    MapEntry<String, int>("7 days", 7),
    MapEntry<String, int>("30 days", 30),
  ];

  MapEntry<String, int> selectedTimeFilter = _timeFilter.first;
  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    final responsiveHelper = ResponsiveHelper(context: context);
    return Padding(
      padding: EdgeInsets.all(responsiveHelper.bigger16Gap),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Summary', style: textTheme.bodyLarge),
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
                          style:
                              textTheme.bodyMedium!.apply(color: primaryColor),
                          // textTheme.bodyMedium!.toLinkStyle(context),
                        )))
                    .toList(),
                onChanged: ((value) {
                  if (value != null) {
                    // setState(() {
                    //   selectedTimeFilter = value;
                    // });
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
      ),
    );
  }
}
