import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_switch.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/profile/core/presentation/widgets/language_bottom_sheet.dart';
import 'package:wmd/features/profile/profile_reset_password/presentation/pages/profile_reset_password_page.dart';

class PreferencesPage extends AppStatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          const PrivacySwitch(),
          const Divider(height: 48),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appLocalizations.profile_tabs_preferences_heading,
                  style: textTheme.titleMedium),
              Text(appLocalizations.profile_tabs_preferences_subHeading,
                  style: textTheme.bodyMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.read<LocalizationManager>().getName(),
                    style: textTheme.bodyMedium!
                        .apply(color: textTheme.bodyLarge!.color!),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return const LanguageBottomSheet();
                            });
                      },
                      child:
                          Text(appLocalizations.profile_changePassword_change))
                ],
              ),
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: e,
                    ))
                .toList(),
          ),
          const Divider(height: 48),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appLocalizations.profile_changePassword_text_password,
                  style: textTheme.titleMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.profile_changePassword_text_password,
                    style: textTheme.bodyMedium!
                        .apply(color: textTheme.bodyLarge!.color!),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProfileRestPasswordPage(),
                            ));
                      },
                      child:
                          Text(appLocalizations.profile_changePassword_heading))
                ],
              ),
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: e,
                    ))
                .toList(),
          ),
          const Divider(height: 48),
          SwitchListTile.adaptive(
            value: context.watch<LocalAuthManager>().state,
            onChanged: (val) {
              context.read<LocalAuthManager>().setLocalAuth(val, context);
            },
            title: Text(appLocalizations.profile_localAuth_enableFaceId),
          ),
        ],
      ),
    );
  }
}
