import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/entities/get_assets_geography_entity.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_chooser.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/assets_overview/core/presentataion/models/assets_overview_base_widget_model.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/entities/get_currency_entity.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_blur_warning.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_geographic_entity.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/inside_world_map_widget.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/dashboard_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/summart_time_filter.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';
import '../../../charts/presentation/manager/charts_cubit.dart';
import '../../../core/domain/entities/assets_overview_base_model.dart';
import '../../../core/presentataion/manager/base_assets_overview_state.dart';
import '../manager/assets_overview_cubit.dart';
import '../widgets/add_button.dart';
import '../widgets/charts_wrapper.dart';
import '../widgets/each_asset_type/each_asset_type.dart';
import '../widgets/overview_card.dart';

class AssetsOverView extends StatefulWidget {
  const AssetsOverView({Key? key}) : super(key: key);

  @override
  AppState<AssetsOverView> createState() => _AssetsOverViewState();
}

class _AssetsOverViewState extends AppState<AssetsOverView> {
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);

    return Builder(builder: (context) {
      return BlocBuilder<MainPageCubit, int>(builder: (context, state) {
        return WillPopScope(
            onWillPop: () {
              debugPrint(
                  'Backbutton pressed (device or appbar button), do whatever you want.');
              context.read<MainPageCubit>().onItemTapped(0);
              //we need to return a future
              return Future.value(false);
            },
            child: SafeArea(
              child: Scaffold(
                appBar: DashboardAppBar(
                    showBack: true,
                    handleGoBack: () =>
                        context.read<MainPageCubit>().onItemTapped(0)),
                body: Stack(
                  children: [
                    const LeafBackground(),
                    WidthLimiterWidget(
                      width: 800,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          outlinedButtonTheme: OutlinedButtonThemeData(
                            style: appTheme.outlinedButtonTheme.style!.copyWith(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(0, 38))),
                          ),
                          elevatedButtonTheme: ElevatedButtonThemeData(
                            style: appTheme.outlinedButtonTheme.style!.copyWith(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(0, 38))),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const PrivacyBlurWarning(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    appLocalizations.assets_page_title,
                                    style: textTheme.titleLarge,
                                  ),
                                  if (AppConstants.publicMvp2Items)
                                    AddButton(
                                      addAsset: false,
                                      onTap: () {
                                        AnalyticsUtils.triggerEvent(
                                            action: AnalyticsUtils
                                                .assetAdditionAction,
                                            params: AnalyticsUtils
                                                .addAssetOverviewEvent);

                                        context
                                            .pushNamed(AppRoutes.addAssetsView);
                                      },
                                    ),
                                ],
                              ),
                              SummaryTimeFilter(
                                key: const Key('OverviewPage'),
                                bloc: context.read<SummeryWidgetCubit>(),
                                onChange: (value) {
                                  context
                                      .read<ChartsCubit>()
                                      .getChart(dateTime: value);
                                },
                              ),
                              const OverViewCard(),
                              const SizedBox(height: 16),
                              const ChartsWrapper(),
                              BlocBuilder<TabManager, int>(
                                builder: (context, state) {
                                  late Cubit bloc;
                                  switch (state) {
                                    case 0:
                                      bloc =
                                          context.read<AssetsOverviewCubit>();
                                      break;
                                    case 1:
                                      bloc = context
                                          .read<AssetsGeographyChartCubit>();
                                      break;
                                    case 2:
                                      bloc = context.read<CurrencyChartCubit>();
                                      break;
                                    default:
                                      bloc =
                                          context.read<AssetsOverviewCubit>();
                                  }
                                  return BlocConsumer(
                                    bloc: bloc,
                                    listener: BlocHelper.defaultBlocListener(
                                      listener: (context, state) {},
                                    ),
                                    builder: (context, state) {
                                      if (state is BaseAssetsOverviewLoaded) {
                                        List<GetGeographicEntity> otherList =
                                            [];
                                        final bool isMapGeo = (state
                                                is GetAssetsGeographyLoaded &&
                                            (context
                                                        .watch<
                                                            GeoChartChooserManager>()
                                                        .state
                                                        ?.barType ??
                                                    GeoBarType.map) ==
                                                GeoBarType.map);
                                        if (isMapGeo) {
                                          double sum = 0;
                                          for (var element in state
                                              .assetsOverviewBaseModels) {
                                            sum += element.totalAmount;
                                          }
                                          otherList = state
                                              .assetsOverviewBaseModels
                                              .map((e) => GetGeographicEntity(
                                                  continent: e.geography,
                                                  amount: e.totalAmount,
                                                  percentage:
                                                      (e.totalAmount / sum) *
                                                          100))
                                              .toList();
                                        }
                                        double sum = 0;
                                        for (var element
                                            in state.assetsOverviewBaseModels) {
                                          sum += element.totalAmount;
                                        }
                                        return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state
                                              .assetsOverviewBaseModels.length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                state.assetsOverviewBaseModels[
                                                    index];
                                            return state
                                                    .assetsOverviewBaseModels[
                                                        index]
                                                    .assetList
                                                    .isEmpty
                                                ? const SizedBox()
                                                : EachAssetType(
                                                    assetsOverviewBaseWidgetModel:
                                                        AssetsOverviewBaseWidgetModel(
                                                      allocation:
                                                          (item.totalAmount *
                                                                  100) /
                                                              sum,
                                                      title: _getTitle(item,
                                                          appLocalizations),
                                                      color: isMapGeo
                                                          ? InsideWorldMapWidgetState
                                                              .getColorByList(
                                                                  (item as GetAssetsGeographyEntity)
                                                                      .geography,
                                                                  otherList)
                                                          : _getColor(
                                                              item,
                                                              index,
                                                              state.assetsOverviewBaseModels[
                                                                  index]),
                                                      assetsOverviewType:
                                                          _getType(item),
                                                      assetsOverviewBaseModel:
                                                          item,
                                                    ),
                                                  );
                                          },
                                        );
                                      } else {
                                        return const LoadingWidget();
                                      }
                                    },
                                  );
                                },
                              )
                            ]
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: e,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
    });
  }

  String _getTitle(
    AssetsOverviewBaseModel item,
    AppLocalizations appLocalizations,
  ) {
    if (item is AssetsOverviewEntity) {
      return AssetsOverviewChartsColors.getAssetType(
          appLocalizations, item.type,
          category: item.subType);
    } else if (item is GetAssetsGeographyEntity) {
      return item.geography;
    } else if (item is GetCurrencyEntity) {
      return item.currencyCode;
    } else {
      return "";
    }
  }

  Color _getColor(AssetsOverviewBaseModel item, int index,
      AssetsOverviewBaseModel assetsOverviewBaseModel) {
    if (item is AssetsOverviewEntity) {
      return AssetsOverviewChartsColors
              .colorsMap[(item.type + (item.subType ?? ""))] ??
          Colors.brown;
    } else {
      return AssetsOverviewChartsColors.treeMapColors[index];
    }
  }

  _getType(AssetsOverviewBaseModel item) {
    if (item is AssetsOverviewEntity) {
      return AssetsOverviewBaseType.assetType;
    } else if (item is GetAssetsGeographyEntity) {
      return AssetsOverviewBaseType.geography;
    } else if (item is GetCurrencyEntity) {
      return AssetsOverviewBaseType.currency;
    } else {
      return AssetsOverviewBaseType.assetType;
    }
  }
}
