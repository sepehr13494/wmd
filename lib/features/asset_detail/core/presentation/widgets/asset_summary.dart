import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/tooltip_bank_exception.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/domain/entities/asset_summary_entity.dart';
import 'package:wmd/features/asset_see_more/core/presentation/page/see_more_page.dart';
import 'package:wmd/features/asset_see_more/core/presentation/widget/see_more_popup.dart';
import 'package:wmd/features/asset_see_more/core/presentation/widget/title_subtitle.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/ytd_itd_widget.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_blur_warning.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'as_of_date_widget.dart';
import 'net_change_widget.dart';
import 'portfolio_contribution_widget.dart';
import 'your_holdings_widget.dart';

class AsssetSummary extends AppStatelessWidget {
  final AssetSummaryEntitiy summary;
  final void Function()? onEdit;
  final Widget? child;
  final int days;
  final String assetId;
  const AsssetSummary({
    required this.summary,
    required this.days,
    required this.assetId,
    this.onEdit,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrivacyBlurWarning(showCloseButton: false),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrivacyBlurWidget(
                  child: Text(
                    summary.assetNameFixed,
                    style: textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // if (summary.assetClassName != null) Text(summary.assetClassName),
              if (onEdit != null)
                Builder(builder: (context) {
                  final isBlurred = PrivacyInherited.of(context).isBlurred;
                  return InkWell(
                    onTap: isBlurred
                        ? null
                        : () {
                            onEdit!();
                          },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2))),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          checkListedAsset(summary.assetClassName)
                              ? appLocalizations.common_button_viewDetails
                              : appLocalizations.common_button_editDetails,
                          style: textTheme.labelMedium!.apply(
                              color: isBlurred
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
          const SizedBox(height: 12),
          if (child != null) child!,
          SummaryCardWidget(
            summary: summary,
            days: days,
            assetId: assetId,
          )
        ],
      ),
    );
  }

  bool checkListedAsset(String assetClassName) {
    switch (assetClassName) {
      case AssetTypes.listedAssetOther:
      case AssetTypes.listedAsset:
      case AssetTypes.listedAssetFixedIncome:
      case AssetTypes.listedAssetEquity:
        return true;
      default:
        return false;
    }
  }
}

class SummaryCardWidget extends AppStatelessWidget {
  final AssetSummaryEntitiy summary;
  final int days;
  final String assetId;
  const SummaryCardWidget({
    required this.summary,
    required this.days,
    required this.assetId,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final lineColor = Theme.of(context).dividerColor;
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    // isMobile = true;
    final gap = responsiveHelper.bigger24Gap;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(color: lineColor),
          borderRadius: BorderRadius.circular(8),
          color: textTheme.bodySmall!.color!.withOpacity(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: gap, top: gap, right: gap),
            child: RowOrColumn(
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              rowMainAxisAlignment: MainAxisAlignment.start,
              showRow: !isMobile,
              children: [
                YourHoldingsWidget(holdings: summary.dealNetWorth),
                !isMobile
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: responsiveHelper.bigger16Gap),
                        width: 1,
                        height: 120,
                        color: Theme.of(context).dividerColor,
                        child: Divider(
                          thickness: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                      )
                    : Divider(
                        thickness: 1,
                        color: Theme.of(context).dividerColor,
                        height: 48,
                      ),
                ExpandedIf(
                  expanded: !isMobile,
                  child: Column(
                    children: [
                      if (!isMobile)
                        _buildHeader(appLocalizations, textTheme, context),
                      RowOrColumn(
                        showRow: !isMobile,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        rowCrossAxisAlignment: CrossAxisAlignment.end,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isMobile)
                            Column(
                              children: [
                                _buildHeader(
                                    appLocalizations, textTheme, context),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: buildChildren(context, textTheme),
                                ),
                              ],
                            ),
                          if (!isMobile) ...buildChildren(context, textTheme),
                          Padding(
                            padding: isMobile
                                ? const EdgeInsets.symmetric(vertical: 12)
                                : const EdgeInsets.symmetric(vertical: 0),
                            child: Builder(builder: (context) {
                              if ((context.read<MainDashboardCubit>().state
                                  is MainDashboardNetWorthLoaded)) {
                                return PortfolioContributionWidget(
                                    portfolioContribution:
                                        summary.dealContribution,
                                    netWorth: (context
                                                .read<MainDashboardCubit>()
                                                .state
                                            as MainDashboardNetWorthLoaded)
                                        .netWorthObj
                                        .totalNetWorth
                                        .currentValue);
                              }
                              return const SizedBox.shrink();
                            }),
                          ),
                          (summary.unRealizedProfitLoss == null)
                              ? const SizedBox()
                              : TitleSubtitle(
                                  title: appLocalizations
                                      .assets_label_unrelaizedGain,
                                  subTitle: summary.unRealizedProfitLoss!
                                      .convertMoney(addDollar: true),
                                  tooltipMessage: appLocalizations
                                      .assets_tooltips_unrealizedGain,
                                  addPrivacy: true,
                                )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          isMobile ? const SizedBox(height: 16) : const SizedBox(),
          if (summary.date != null) AsOfDateWidget(shownDate: summary.date),
        ],
      ),
    );
  }

  Row _buildHeader(AppLocalizations appLocalizations, TextTheme textTheme,
      BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BankTooltip(
          showTooltip: summary.assetClassName == AssetTypes.bankAccount,
          child: Text(
            appLocalizations.assets_label_netChange,
            style: textTheme.titleSmall,
          ),
        ),
        Builder(builder: (context) {
          // return const SizedBox();
          if (AppConstants.isRelease2) {
            return TextButton(
              onPressed: () {
                showSeeMoreModal(
                    context: context,
                    child: SeeMorePage(
                      id: assetId,
                      type: summary.assetClassName,
                    ));
              },
              child: Text(
                '${appLocalizations.common_button_seeMore} >',
                style: textTheme.labelSmall!.apply(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline),
              ),
            );
          }
          return const SizedBox();
        }),
      ],
    );
  }

  List<Widget> buildChildren(context, textTheme) {
    return [
      NetChangeWidget(
        days: days,
        change: summary.netChange,
      ),
      YtdItdWidget(
        expand: false,
        ytd: summary.ytdPerformance,
        itd: summary.itdPerformance,
      ),
    ];
  }
}
