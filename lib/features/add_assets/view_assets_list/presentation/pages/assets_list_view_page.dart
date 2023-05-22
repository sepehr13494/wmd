import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/page/custodian_banks_page.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/manager/asset_view_cubit.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/each_asset_widget.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/dashboard_app_bar.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/add_asset_onboarding_view.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/injection_container.dart';

const double _padding = 16;

class AssetsListViewPage extends AppStatelessWidget {
  final int initial;
  const AssetsListViewPage({this.initial = 0, Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<AssetViewCubit>(),
      child: Scaffold(
        appBar: const BaseAppBar(enableActions: false),
        bottomSheet: Builder(builder: (context) {
          final state = context.watch<AssetViewCubit>().state;
          if (state is CustodianPage) {
            return const SizedBox.shrink();
          }
          return AddAssetFooter(
              buttonText: state == null
                  ? appLocalizations.common_button_addAsset
                  : (state as EachAssetModel).pageRoute ==
                          AppRoutes.addLiability
                      ? appLocalizations.common_button_addLiability
                      : appLocalizations.common_button_addAsset,
              onTap: state == null
                  ? null
                  : () {
                      context.pushNamed((state as EachAssetModel).pageRoute);
                    });
        }),
        body: Stack(
          children: [
            const LeafBackground(
              opacity: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _padding),
              child: ResponsiveWidget(
                mobile: AssetTabWrapper(initial: initial),
                desktop: AddAssetTabletView(initial: initial),
                tablet: AddAssetTabletView(initial: initial),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAssetTabletView extends StatelessWidget {
  final int initial;
  const AddAssetTabletView({Key? key, required this.initial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 3, child: AddAssetTopWidget()),
        const SizedBox(width: 16),
        Container(
          margin: const EdgeInsets.only(top: 24, right: 10),
          width: 0.5,
          height: 450,
          color: AppColors.dashboardDividerColor,
        ),
        const SizedBox(width: 16),
        Expanded(
            flex: ResponsiveHelper(context: context).isDesktop ? 6 : 4,
            child: AssetTabWrapper(initial: initial))
      ],
    );
  }
}

class AssetTabWrapper extends StatefulWidget {
  final int initial;
  const AssetTabWrapper({Key? key, required this.initial}) : super(key: key);

  @override
  AppState<AssetTabWrapper> createState() => _AssetTabWrapperState();
}

class _AssetTabWrapperState extends AppState<AssetTabWrapper>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool showMvp2 = AppConstants.publicMvp2Items;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: showMvp2 ? 3 : 1,
        vsync: this,
        initialIndex: showMvp2 ? widget.initial : 0);
    if (showMvp2) {
      _tabController.addListener(() {
        if (_tabController.index == 2) {
          context.read<AssetViewCubit>().selectCustodian();
        } else {
          context.read<AssetViewCubit>().empty();
        }
      });
    } else {
      context.read<AssetViewCubit>().selectCustodian();
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    var isMobile = ResponsiveHelper(context: context).isMobile;
    return NestedScrollView(
        headerSliverBuilder: (context, isInnerScroll) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
              isMobile ? const AddAssetTopWidget() : const SizedBox(),
              const ChooseAssetWidget(),
            ]))
          ];
        },
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: isMobile
                      ? MediaQuery.of(context).size.width - (_padding * 2)
                      : MediaQuery.of(context).size.width / 2,
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      if (showMvp2)
                        Tab(text: appLocalizations.assets_breadCrumb_assets),
                      if (showMvp2)
                        Tab(
                            text: appLocalizations
                                .liabilities_breadCrumb_liabilities),
                      Tab(text: appLocalizations.common_labels_custodianBank),
                    ],
                    isScrollable: true,
                    // labelStyle: textTheme.bodySmall,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Divider(
              height: 0.5,
              thickness: 0.5,
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                if (showMvp2) const AssetsPart(isLiability: false),
                if (showMvp2)
                  const AssetsPart(
                    isLiability: true,
                  ),
                const AddCustodianBanksPage(),
              ],
            ))
          ],
        ));
  }
}

class ChooseAssetWidget extends AppStatelessWidget {
  const ChooseAssetWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.manage_assetAndLiability_custodianBankTitle,
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          // Text(
          //   appLocalizations.manage_assetAndLiability_description,
          //   style: textTheme.bodySmall,
          // ),
        ],
      ),
    );
  }
}

class AssetsPart extends AppStatelessWidget {
  final bool isLiability;

  const AssetsPart({Key? key, required this.isLiability}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);

    late List<EachAssetModel> assets;
    if (isLiability) {
      assets = [
        EachAssetModel(
            id: 1,
            image: "assets/images/add_assets/bank_asset.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_loan_title,
            pageRoute: AppRoutes.addLiability,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_loan_description)
      ];
    } else {
      assets = [
        EachAssetModel(
          id: 2,
          pageRoute: AppRoutes.addBankManualPage,
          image: "assets/images/add_assets/bank_asset.svg",
          title: appLocalizations
              .manage_assetAndLiability_assetAndLiabilityList_bankAccount_title,
          description: appLocalizations
              .manage_assetAndLiability_assetAndLiabilityList_bankAccount_description,
        ),
        EachAssetModel(
            id: 5,
            pageRoute: AppRoutes.addRealEstate,
            image: "assets/images/add_assets/real_estate.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_realEstate_title,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_realEstate_description),
        EachAssetModel(
            id: 3,
            pageRoute: AppRoutes.addListedAsset,
            image: "assets/images/add_assets/listed_asset.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_listedAssets_title,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_listedAssets_description),
        EachAssetModel(
            id: 6,
            pageRoute: AppRoutes.addPrivateEquity,
            image: "assets/images/add_assets/private_equity.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_privateEquity_title,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_privateEquity_description),
        EachAssetModel(
          id: 4,
          pageRoute: AppRoutes.addPrivateDebt,
          image: "assets/images/add_assets/privet_debt.svg",
          title: appLocalizations
              .manage_assetAndLiability_assetAndLiabilityList_privateDebt_title,
          description: appLocalizations
              .manage_assetAndLiability_assetAndLiabilityList_privateDebt_description,
        ),
        EachAssetModel(
            id: 7,
            pageRoute: AppRoutes.addOther,
            image: "assets/images/add_assets/others.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_others_title,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_others_description),
      ];
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: responsiveHelper.isDesktop ? 2 : 1,
              crossAxisSpacing: responsiveHelper.defaultGap,
              mainAxisSpacing: responsiveHelper.defaultGap,
              mainAxisExtent: 140, // here set custom Height You Want
            ),
            itemCount: assets.length,
            itemBuilder: (BuildContext context, int index) {
              return EachAssetWidget(
                eachAssetModel: assets[index],
              );
            },
          ),
          !ResponsiveHelper(context: context).isMobile
              ? const SupportWidget()
              : const SizedBox(),
          const SizedBox(height: 84),
        ],
      ),
    );
  }
}

class AddAssetTopWidget extends AppStatelessWidget {
  const AddAssetTopWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;

    final isAssetsNotEmpty =
        context.read<MainDashboardCubit>().netWorthObj?.assets.currentValue !=
            0;
    final isLiabilityNotEmpty = context
            .read<MainDashboardCubit>()
            .netWorthObj
            ?.liabilities
            .currentValue !=
        0;

    final isCustodianNotEmpty =
        context.read<CustodianStatusListCubit>().statutes.isNotEmpty;

    if (isAssetsNotEmpty || isLiabilityNotEmpty || isCustodianNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          BlocBuilder<PersonalInformationCubit, PersonalInformationState>(
            builder: (context, state) {
              String name = "";
              if (state is PersonalInformationLoaded) {
                name = state.getNameEntity.firstName;
              }
              return Text(
                  appLocalizations.manage_heading.replaceFirst("{{name}}", ""),
                  style: textTheme.headlineSmall);
            },
          ),
          const SizedBox(height: 8),
          WidthLimiterWidget(
            width: 350,
            child: Text(appLocalizations.manage_subHeading),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/add_asset_view.png",
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        appLocalizations.manage_securityInfoWidget_title,
                        style:
                            textTheme.titleMedium!.apply(color: primaryColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        appLocalizations.manage_securityInfoWidget_description,
                        style: textTheme.bodyMedium!
                            .apply(color: AppColors.dashBoardGreyTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return const AddAssetOnBoarding();
    }
  }
}
