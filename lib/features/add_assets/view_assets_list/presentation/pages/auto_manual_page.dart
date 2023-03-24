import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';

class AutoManualPage extends AppStatelessWidget {
  const AutoManualPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: const AddAssetHeader(title: "", showExitModal: true),
      body: Stack(
        children: [
          const LeafBackground(),
          WidthLimiterWidget(
            width: 700,
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Text(
                  appLocalizations.linkAccount_linkAccount_heading,
                  style: textTheme.headlineSmall,
                ),
                AutoManualCard(
                  icon: Icons.remove_red_eye_outlined,
                  title: appLocalizations
                      .linkAccount_linkAccount_card_automatic_title,
                  description: appLocalizations
                      .linkAccount_linkAccount_card_automatic_description,
                  onTap: () {
                    context.pushNamed(AppRoutes.addBankAutoPage);
                  },
                  buttonText:
                      appLocalizations.linkAccount_linkAccount_button_automatic,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        appLocalizations.linkAccount_linkAccount_text_or,
                        style: textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                AutoManualCard(
                  icon: Icons.link,
                  title: appLocalizations
                      .linkAccount_linkAccount_card_manual_title,
                  description: appLocalizations
                      .linkAccount_linkAccount_card_manual_description,
                  onTap: () {
                    context.pushNamed(AppRoutes.addBankManualPage);
                  },
                  buttonText:
                      appLocalizations.linkAccount_linkAccount_button_manual,
                ),
                const SupportWidget(),
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class AutoManualCard extends AppStatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final Function onTap;

  const AutoManualCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description,
      required this.onTap,
      required this.buttonText})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(responsiveHelper.biggerGap),
        child: RowOrColumn(
          showRow: !isMobile,
          children: [
            ExpandedIf(
              expanded: !isMobile,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            !isMobile
                ? SizedBox(width: responsiveHelper.bigger16Gap)
                : SizedBox(height: responsiveHelper.bigger16Gap),
            ExpandedIf(
              expanded: !isMobile,
              child: ElevatedButton(
                  onPressed: () {
                    onTap();
                  },
                  child: Text(buttonText)),
            )
          ],
        ),
      ),
    );
  }
}
