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
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/page/custodian_banks_page.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/manager/asset_view_cubit.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/each_asset_widget.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/add_asset_onboarding_view.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/onboarding_appbar.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/global_variables.dart';
import 'package:wmd/injection_container.dart';

class AssetsListViewPage extends AppStatelessWidget {
  const AssetsListViewPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    PreferredSizeWidget? renderAppBar() {
      if (sl<GetUserStatusUseCase>().showOnboarding) {
        return const OnboardingAppBar(page: 1, isAsset: true);
      } else {
        return const BaseAppBar(title: "Add assets");
      }
    }

    return BlocProvider(
      create: (context) => sl<AssetViewCubit>(),
      child: Scaffold(
        appBar: renderAppBar(),
        bottomSheet: Builder(builder: (context) {
          final state = context.watch<AssetViewCubit>().state;
          if (state is CustodianPage) {
            return const SizedBox.shrink();
          }
          return AddAssetFooter(
              buttonText: "Add Asset",
              onTap: state == null
                  ? () {}
                  : () {
                      context.pushNamed((state as EachAssetModel).pageRoute);
                    });
        }),
        body: Stack(
          children: const [
            LeafBackground(
              opacity: 0.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ResponsiveWidget(
                mobile: AddAssetMobileWidget(),
                desktop: AddAssetTabletView(),
                tablet: AddAssetTabletView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAssetTabletView extends StatelessWidget {
  const AddAssetTabletView({Key? key}) : super(key: key);

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
            child: const AddAssetMobileWidget())
      ],
    );
  }
}

class AddAssetMobileWidget extends StatefulWidget {
  const AddAssetMobileWidget({Key? key}) : super(key: key);

  @override
  AppState<AddAssetMobileWidget> createState() => _AddAssetMobileWidgetState();
}

class _AddAssetMobileWidgetState extends AppState<AddAssetMobileWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 2) {
        context.read<AssetViewCubit>().selectCustodian();
      } else {
        context.read<AssetViewCubit>().empty();
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return NestedScrollView(
        headerSliverBuilder: (context, isInnerScroll) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
              ResponsiveHelper(context: context).isMobile
                  ? const AddAssetTopWidget()
                  : const SizedBox(),
              const ChooseAssetWidget(),
            ]))
          ];
        },
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: "Assets"),
                      Tab(text: "Liability"),
                      Tab(text: "Custodian Banks"),
                    ],
                    isScrollable: true,
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
              children: const [
                AssetsPart(isLiability: false),
                AssetsPart(
                  isLiability: true,
                ),
                AddCustodianBanksPage(),
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
            "Choose an asset / Liability",
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            "you can add more later",
            style: textTheme.bodySmall,
          ),
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
          pageRoute: AppRoutes.autoManualPage,
          image: "assets/images/add_assets/bank_asset.svg",
          title: appLocalizations
              .manage_assetAndLiability_assetAndLiabilityList_bankAccount_title,
          description: appLocalizations
              .manage_assetAndLiability_assetAndLiabilityList_bankAccount_description,
        ),
        EachAssetModel(
            id: 3,
            pageRoute: AppRoutes.addListedAsset,
            image: "assets/images/add_assets/listed_asset.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_listedAssets_title,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_listedAssets_description),
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
            id: 5,
            pageRoute: AppRoutes.addRealEstate,
            image: "assets/images/add_assets/real_estate.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_realEstate_title,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_realEstate_description),
        EachAssetModel(
            id: 6,
            pageRoute: AppRoutes.addPrivateEquity,
            image: "assets/images/add_assets/private_equity.svg",
            title: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_privateEquity_title,
            description: appLocalizations
                .manage_assetAndLiability_assetAndLiabilityList_privateEquity_description),
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
          ResponsiveHelper(context: context).isMobile
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

    if (sl<GetUserStatusUseCase>().showOnboarding) {
      return const AddAssetOnBoarding();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text("Hi !", style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          const WidthLimiterWidget(
            width: 350,
            child: Text(
                "Diversify your portfolio by adding an asset or a liability"),
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
                        "Your privacy & data security is our utmost priority",
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
                        "Your credentials are never accessible to any other service. Your data is secured in transit using bank grade TLS 1.2 technology.",
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
    }
  }
}
