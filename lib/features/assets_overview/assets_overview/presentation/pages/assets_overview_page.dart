import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/app_theme.dart';

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
            Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: appTheme.outlinedButtonTheme.style!.copyWith(
                      minimumSize:
                      MaterialStateProperty.all(const Size(0, 48))),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: appTheme.outlinedButtonTheme.style!.copyWith(
                      minimumSize:
                      MaterialStateProperty.all(const Size(0, 48))),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
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
                    OverViewCard()
                  ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8),child: e,)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverViewCard extends AppStatelessWidget {
  const OverViewCard({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
        color: textTheme.bodySmall!.color!.withOpacity(0.05)
      ),
      padding: EdgeInsets.all(responsiveHelper.bigger24Gap),
      child: RowOrColumn(
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        showRow: !isMobile,
        children: [
          ExpandedIf(
            expanded: !isMobile,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your holdings",style: textTheme.titleSmall,),
                SizedBox(height: responsiveHelper.bigger16Gap),
                Text("\$8,845,000",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w300),)
              ],
            ),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Net change",style: textTheme.titleSmall,),
              SizedBox(height: responsiveHelper.bigger16Gap),
              RowOrColumn(
                showRow: !isMobile,
                children: [
                  Padding(
                    padding: EdgeInsets.all(responsiveHelper.bigger16Gap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Last 365 days",style: textTheme.bodySmall,),
                        Row(
                          children: [
                            Text("\$1,326,320",style: textTheme.bodyLarge,),
                            ChangeWidget(number: 8.03, text: "8.03%"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(2, (index) {
                      return Padding(
                        padding: EdgeInsets.all(responsiveHelper.bigger16Gap),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("YTD",style: textTheme.bodySmall,),
                                const InfoIcon(),
                              ],
                            ),
                            ChangeWidget(number: 8.03, text: "8.03%"),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


class AddButton extends StatelessWidget {
  final void Function() onTap;
  final bool addAsset;

  const AddButton({
    Key? key,
    required this.onTap,
    this.addAsset = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_circle_outlined),
            const SizedBox(width: 8),
            Text("Add")
          ],
        ));
  }
}
