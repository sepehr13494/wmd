import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';

class SupportWidget extends AppStatelessWidget {
  const SupportWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/images/add_assets/question.svg")),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.common_help_heading,
              style: textTheme.bodyMedium!
                  .apply(color: AppColors.dashBoardGreyTextColor),
            ),
            InkWell(
              onTap: () {
                context.goNamed(AppRoutes.support);
              },
              child: Text(
                appLocalizations.common_help_link_support,
                style: textTheme.bodyMedium!,
              ),
            ),
          ],
        )
      ],
    );
  }
}
