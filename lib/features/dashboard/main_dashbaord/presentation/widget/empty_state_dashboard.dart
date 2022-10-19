import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/icon_text.dart';

class EmptyStateDashboard extends AppStatelessWidget {
  final ResponsiveHelper responsiveHelper;
  const EmptyStateDashboard({required this.responsiveHelper, Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RowOrColumn(
        showRow: !responsiveHelper.isMobile,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpandedIf(
            expanded: !responsiveHelper.isMobile,
            child: const IconText(
              image: "assets/images/dashboard/dashboard_empty_home.svg",
              text: "We support multiple asset classes and currencies.",
            ),
          ),
          if (!responsiveHelper.isMobile) ...[
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              height: 150,
              width: 0.8,
              color: AppColors.dashboardDividerColor,
            )
          ],
          ExpandedIf(
            expanded: !responsiveHelper.isMobile,
            child: const IconText(
              image: "assets/images/dashboard/dashboard_empty_bank.svg",
              text:
                  "Connect with your institutions and avoid the hassle of manual updates.",
            ),
          ),
          if (!responsiveHelper.isMobile) ...[
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              height: 150,
              width: 0.8,
              color: AppColors.dashboardDividerColor,
            )
          ],
          ExpandedIf(
            expanded: !responsiveHelper.isMobile,
            child: const IconText(
              image: "assets/images/dashboard/dashboard_empty_sheild.svg",
              text:
                  'We use the highest security encryption with your data to make sure it is always safe.',
            ),
          ),
        ],
      ),
    );
  }
}
