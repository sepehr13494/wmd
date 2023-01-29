import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/icon_text.dart';
import 'package:wmd/features/dashboard/onboarding/data/models/onboarding_config.dart';

class EmptyStateDashboard extends AppStatelessWidget {
  final ResponsiveHelper responsiveHelper;
  final List<dynamic> config;
  final String type;

  const EmptyStateDashboard(
      {required this.responsiveHelper,
      required this.config,
      this.type = "default",
      Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RowOrColumn(
          intrinsicRow: true,
          showRow: !responsiveHelper.isMobile,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          children: config
              .map((dynamic e) => ExpandedIf(
                    expanded: !responsiveHelper.isMobile,
                    child: Stack(children: [
                      IconText(
                        image: e.image,
                        text: e.text,
                        type: type,
                      ),
                      if (!responsiveHelper.isMobile && e.key != 1) ...[
                        Container(
                          margin: const EdgeInsets.only(right: 40, top: 30),
                          height: 210,
                          width: 0.8,
                          color: AppColors.dashboardDividerColor,
                        )
                      ],
                    ]),
                  ))
              .toList()),
    );
  }
}
