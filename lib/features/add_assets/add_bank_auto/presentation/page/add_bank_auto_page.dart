import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/add_bank_auto/presentation/widget/your_privacy.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';

class AddBankAutoPage extends AppStatelessWidget {
  const AddBankAutoPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect your account")),
      body: SafeArea(
        child: Stack(
          children: [
            const LeafBackground(
              opacity: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text("Add listed asset details",
                      style: textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Text(
                    "Current account, savings account and term deposit accounts.",
                    style: textTheme.titleSmall!
                        .apply(color: AppColors.dashBoardGreyTextColor),
                  ),
                  const SizedBox(height: 16),
                  const YourPrivacyWidget(),
                  const SizedBox(height: 16),
                  Text("Link you bank accounts", style: textTheme.headline6),
                  const SizedBox(height: 8),
                  Text("Search for your bank or select an option below",
                      style: textTheme.bodyLarge),
                  Expanded(child: ListView()),
                  const SupportWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
