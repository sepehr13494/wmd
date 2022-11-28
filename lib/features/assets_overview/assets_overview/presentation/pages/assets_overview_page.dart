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

import '../manager/assets_overview_cubit.dart';
import '../widgets/add_button.dart';
import '../widgets/each_asset_type/each_asset_type.dart';
import '../widgets/overview_card.dart';

class AssetsOverView extends AppStatelessWidget {
  const AssetsOverView({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const LeafBackground(),
            WidthLimiterWidget(
              width: 800,
              child: Theme(
                data: Theme.of(context).copyWith(
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: appTheme.outlinedButtonTheme.style!.copyWith(
                        minimumSize:
                            MaterialStateProperty.all(const Size(0, 38))),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: appTheme.outlinedButtonTheme.style!.copyWith(
                        minimumSize:
                            MaterialStateProperty.all(const Size(0, 38))),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Assets",
                            style: textTheme.titleLarge,
                          ),
                          AddButton(
                            addAsset: false,
                            onTap: () {
                              context.pushNamed(AppRoutes.addAssetsView);
                            },
                          ),
                        ],
                      ),
                      const OverViewCard(),
                      BlocConsumer<AssetsOverviewCubit, AssetsOverviewState>(
                        listener: BlocHelper.defaultBlocListener(
                          listener: (context, state) {},
                        ),
                        builder: BlocHelper.defaultBlocBuilder(
                            builder: (context, state) {
                          if (state is AssetsOverviewLoaded) {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.assetsOverviews.length,
                              itemBuilder: (context, index) => EachAssetType(
                                  assetsOverview: state.assetsOverviews[index]),
                              separatorBuilder: (context, _) =>
                                  const Divider(height: 24),
                            );
                          } else {
                            return const LoadingWidget();
                          }
                        }),
                      )
                    ]
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}
