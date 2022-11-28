import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';

class YourPrivacyWidget extends AppStatelessWidget {
  const YourPrivacyWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
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
                "assets/images/add_asset_view.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  appLocalizations.manage_securityInfoWidget_title,
                  style: textTheme.titleMedium!.apply(color: primaryColor),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  appLocalizations.manage_securityInfoWidget_description,
                  style: textTheme.bodyMedium!
                      .apply(color: AppColors.dashBoardGreyTextColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
