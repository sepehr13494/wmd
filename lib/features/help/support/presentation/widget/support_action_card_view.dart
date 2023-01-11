import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/icon_text.dart';
import 'package:wmd/features/dashboard/onboarding/data/models/onboarding_config.dart';

class SupportActionCard extends AppStatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final VoidCallback action;

  const SupportActionCard(
      {required this.icon,
      required this.title,
      required this.desc,
      required this.action,
      Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.anotherCardColorForDarkTheme
          : AppColors.anotherCardColorForLightTheme,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListTile(
          minVerticalPadding: 10,
          onTap: () {
            action();
          },
          title: Text(title),
          leading: Icon(
            icon,
            color: AppColors.primary,
          ),
          subtitle: Text(
            desc,
            style: textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
