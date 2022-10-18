import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/each_asset_widget.dart';
import 'package:wmd/global_variables.dart';

class AssetsListViewPage extends AppStatelessWidget {
  const AssetsListViewPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: BaseAppBar(title: "add assets"),
      body: Stack(
        children: const [
          LeafBackground(opacity: 0.5,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ResponsiveWidget(mobile: AddAssetMobileWidget(), desktop: AddAssetTabletView(), tablet: AddAssetTabletView(),),
          ),
        ],
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
        const Expanded(flex: 3,child: AddAssetTopWidget()),
        const SizedBox(width: 16),
        Container(
          margin: const EdgeInsets.only(top: 24),
          width: 0.5,
          height: 300,
          color: Theme.of(context).dividerColor,
        ),
        const SizedBox(width: 16),
        Expanded(flex: ResponsiveHelper(context: context).isDesktop ? 6 : 4,child: const AddAssetMobileWidget())
      ],
    );
  }
}


class AddAssetMobileWidget extends AppStatelessWidget {
  const AddAssetMobileWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return NestedScrollView(headerSliverBuilder: (context, isInnerScroll){
      return [
        SliverList(delegate: SliverChildListDelegate([
          ResponsiveHelper(context: context).isMobile? const AddAssetTopWidget() : const SizedBox(),
          const ChooseAssetWidget(),
        ]))
      ];
    }, body: DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 300,
                child: TabBar(tabs: [
                  Tab(text: "assets"),
                  Tab(text: "Libelity"),
                ]),
              ),
              Spacer(),
            ],
          ),
          const Divider(height: 0.5,thickness: 0.5,),
          Expanded(child: TabBarView(children: [
            AssetsPart(isLiability: false),
            AssetsPart(isLiability: true,)
          ]))
        ],
      ),
    ));
  }
}


class ChooseAssetWidget extends AppStatelessWidget {
  const ChooseAssetWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Choose an asset / Liabelty",style: textTheme.titleLarge,),
          const SizedBox(height: 8),
          Text("you can add more later",style: textTheme.bodySmall,),
        ],
      ),
    );
  }
}

class AssetsPart extends AppStatelessWidget {
  final bool isLiability;
  const AssetsPart({Key? key,required this.isLiability}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    late List<EachAssetModel> assets;
    if(isLiability){
      assets = [
        EachAssetModel(image: "assets/images/add_assets/bank_asset.svg", title: "Liability", description: loroIpsum)
      ];
    }else{
      assets = [
        EachAssetModel(image: "assets/images/add_assets/bank_asset.svg", title: "Bank Account", description: "Current account, savings account and term deposit accounts."),
        EachAssetModel(image: "assets/images/add_assets/bank_asset.svg", title: "Listed assets", description: "Investments made in stocks, ETFs, bonds and mutual funds."),
        EachAssetModel(image: "assets/images/add_assets/bank_asset.svg", title: "Private debt", description: "Asset defined by non-bank lending where debt is not issued or traded on the public markets"),
        EachAssetModel(image: "assets/images/add_assets/bank_asset.svg", title: "Real estate", description: "Current account, savings account and term deposit accounts."),
        EachAssetModel(image: "assets/images/add_assets/bank_asset.svg", title: "Private equity", description: "Current account, savings account and term deposit accounts."),
        EachAssetModel(image: "assets/images/add_assets/bank_asset.svg", title: "Others", description: "Current account, savings account and term deposit accounts."),
      ];
    }
    return  GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsiveHelper.isDesktop ? 2 : 1,
        crossAxisSpacing: responsiveHelper.defaultGap,
        mainAxisSpacing: responsiveHelper.defaultGap,
        mainAxisExtent: 140, // here set custom Height You Want
      ),
      itemCount: assets.length,
      itemBuilder: (BuildContext context, int index) {
        return EachAssetWidget(eachAssetModel: assets[index],);
      },
    );
  }
}

class AddAssetTopWidget extends AppStatelessWidget {
  const AddAssetTopWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text("Hi Ahmad!", style: textTheme.headlineSmall),
        const SizedBox(height: 8),
        WidthLimiterWidget(
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
                      "assets/images/add_asset_view.png",width: 100,height: 100,),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Your privacy & data security is our utmost priority",
                      style: textTheme.titleMedium!
                          .apply(color: primaryColor),
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
                      style: textTheme.bodyMedium!.apply(color: AppColors.dashBoardGreyTextColor),
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



