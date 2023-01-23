import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/features/asset_see_more/core/presentation/widget/title_subtitle.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

import '../../../../../core/presentation/widgets/responsive_helper/responsive_helper.dart';
import '../../data/model/other_asset_more_entity.dart';

class OtherAssetDetailPage extends AppStatelessWidget {
  final OtherAseetMoreEntity entity;
  const OtherAssetDetailPage({super.key, required this.entity});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final netWorth = (context.read<MainDashboardCubit>().state
            as MainDashboardNetWorthLoaded)
        .netWorthObj
        .totalNetWorth
        .currentValue;
    final country = TitleSubtitle(
      title: appLocalizations.assets_seeMore_labels_country,
      subTitle: CountryService()
              .findByCode(entity.country)
              ?.displayNameNoCountryCode ??
          entity.country,
    );

    var type = TitleSubtitle(
      title: appLocalizations.assets_seeMore_labels_type,
      subTitle: entity.type.toString(),
    );
    var acquisCost = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_acquisitionCost,
        subTitle: entity.acquisitionCost.toString());
    var acquisDate = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_acquisitionDate,
        subTitle:
            CustomizableDateTime.localizedDdMmYyyy(entity.acquisitionDate));
    var currentValue = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_currentTotalValue,
        subTitle: entity.holdings.convertMoney(addDollar: true));
    var ownerShip = TitleSubtitle(
        title: appLocalizations.assets_label_ownership,
        subTitle: '${entity.ownerShip}%');
    var ownerShipBasedValue = TitleSubtitle(
        title: appLocalizations.assets_label_ownershipBased,
        subTitle: entity.holdings.convertMoney(addDollar: true));
    var assetClass = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_assetClass,
        subTitle: AssetsOverviewChartsColors.getAssetType(
            appLocalizations, AssetTypes.otherAsset));
    var assetClassContr = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_assetClassContribution,
        subTitle: 'Not data');
    var portfolioCont = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_portfolioContribution,
        subTitle:
            '${entity.portfolioContribution}% of ${netWorth.convertMoney(addDollar: true)}');
    var accountAddded = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_accountAdded,
        subTitle: CustomizableDateTime.localizedDdMmYyyy(entity.valuationDate));
    var ytd = TitleChangeSubtitle(
      title: appLocalizations.assets_seeMore_labels_ytd,
      subTitle: entity.holdings.convertMoney(addDollar: true),
      value: 12,
    );
    var itd = TitleChangeSubtitle(
      title: appLocalizations.assets_seeMore_labels_itd,
      subTitle: entity.holdings.convertMoney(addDollar: true),
      value: 12,
    );
    final gap = ResponsiveHelper(context: context).bigger24Gap;
    final dividerGap = gap * 1.8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entity.name, style: textTheme.titleLarge),
          const SizedBox(height: 24),
          Text(appLocalizations.assets_seeMore_labels_basicDetails,
              style: textTheme.bodyLarge),
          SizedBox(height: gap),
          Wrap(
            runSpacing: 16,
            spacing: gap,
            children: [
              country,
              type,
              acquisCost,
              acquisDate,
              currentValue,
              ownerShip,
              ownerShipBasedValue
            ],
          ),
          Divider(
            height: dividerGap,
            color: Theme.of(context).hintColor,
          ),
          Row(
            children: [
              Text(appLocalizations.assets_seeMore_labels_performance,
                  style: textTheme.bodyLarge),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: Theme.of(context).primaryColor,
                size: 14,
              )
            ],
          ),
          SizedBox(height: gap),
          Wrap(
            runSpacing: 16,
            spacing: gap,
            children: [ytd, itd],
          ),
          Divider(
            height: dividerGap,
            color: Theme.of(context).hintColor,
          ),
          Text(appLocalizations.assets_seeMore_labels_assetContribution,
              style: textTheme.bodyLarge),
          SizedBox(height: gap),
          Wrap(
            runSpacing: 16,
            spacing: gap,
            children: [assetClass, assetClassContr, portfolioCont],
          ),
          Divider(
            height: dividerGap,
            color: Theme.of(context).hintColor,
          ),
          Text(appLocalizations.assets_seeMore_labels_otherInformation,
              style: textTheme.bodyLarge),
          SizedBox(height: gap),
          accountAddded,
          Divider(
            height: dividerGap,
            color: Theme.of(context).hintColor,
          ),
          SizedBox(height: gap),
          const SupportWidget(),
          SizedBox(height: gap),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Text(appLocalizations.common_button_deleteAsset))),
              const SizedBox(width: 12),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(appLocalizations.common_button_edit))),
            ],
          ),
          SizedBox(height: gap),
        ],
      ),
    );
  }
}
