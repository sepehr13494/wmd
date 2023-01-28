import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/features/asset_see_more/core/presentation/widget/title_subtitle.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

import '../../../../../core/presentation/widgets/responsive_helper/responsive_helper.dart';
import '../../data/model/bank_account_more_entity.dart';

class BankAccountMorePage extends AppStatelessWidget {
  final BankAccountMoreEntity entity;
  const BankAccountMorePage({super.key, required this.entity});

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

    final type = TitleSubtitle(
      title: appLocalizations.assets_seeMore_labels_type,
      subTitle: entity.accountType.toString(),
    );
    final bankName = TitleSubtitle(
      title: 'Bank name',
      subTitle: entity.bankName,
    );
    final currency = TitleSubtitle(
      title: 'Currency',
      subTitle: entity.currencyCode,
    );

    final currentBalance = TitleSubtitle(
        title: 'Currency balance',
        subTitle: entity.currentBalance.convertMoney(addDollar: true));
    final interestRate = TitleSubtitle(
        title: 'interestRate', subTitle: '${entity.interestRate}%');
    final startingBalance = TitleSubtitle(
        title: 'Starting balance',
        subTitle: entity.holdings.convertMoney(addDollar: true));

    final assetClass = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_assetClass,
        subTitle: AssetsOverviewChartsColors.getAssetType(
            appLocalizations, AssetTypes.otherAsset));

    final assetClassContr = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_assetClassContribution,
        subTitle: 'Not data');
    final portfolioCont = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_portfolioContribution,
        subTitle:
            '${entity.portfolioContribution}% of ${netWorth.convertMoney(addDollar: true)}');
    final accountAddded = TitleSubtitle(
        title: appLocalizations.assets_seeMore_labels_accountAdded,
        subTitle: CustomizableDateTime.localizedDdMmYyyy(entity.asOfDate));
    final netChange = TitleChangeSubtitle(
      bigTitle: 'Net change',
      title: 'Last 30 days',
      subTitle: entity.currentBalance.convertMoney(addDollar: true),
      value: 12,
    );

    final gap = ResponsiveHelper(context: context).bigger24Gap;
    final dividerGap = gap * 1.8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entity.bankName, style: textTheme.titleLarge),
          const SizedBox(height: 24),
          Text(appLocalizations.assets_seeMore_labels_basicDetails,
              style: textTheme.bodyLarge),
          SizedBox(height: gap),
          Wrap(
            runSpacing: 16,
            spacing: gap,
            children: [
              bankName,
              country,
              currency,
              type,
              startingBalance,
              currentBalance,
              interestRate,
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
              const InfoIcon(),
            ],
          ),
          SizedBox(height: gap),
          Wrap(
            runSpacing: 16,
            spacing: gap,
            children: [netChange],
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
