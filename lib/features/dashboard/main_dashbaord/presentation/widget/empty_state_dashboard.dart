import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';

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
          // if (!responsiveHelper.isMobile) ...[
          //   Divider(),
          // ],
          if (!responsiveHelper.isMobile) ...[
            Container(
              height: 100,
              width: 5,
              color: AppColors.accent,
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
          if (!responsiveHelper.isMobile) ...[
            const VerticalDivider(
              color: AppColors.accent,
              thickness: 10,
            ),
            Container(
              height: 100,
              width: 5,
              color: AppColors.accent,
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
        ],
      ),
    );
  }
}

class IconText extends AppStatelessWidget {
  final String image;
  final String text;
  const IconText({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 32),
          child: SvgPicture.asset(
            image,
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Text(
            text,
            style: textTheme.labelMedium
                ?.apply(color: AppColors.dashBoardGreyTextColor),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
