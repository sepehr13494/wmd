import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/profile/core/presentation/widgets/language_bottom_sheet.dart';
import 'package:wmd/features/profile/personal_information/presentation/widgets/personal_imformation_widget.dart';
import 'package:wmd/features/profile/profile_reset_password/presentation/pages/profile_reset_password_page.dart';
import 'package:wmd/injection_container.dart';

import '../../../personal_information/presentation/manager/personal_information_cubit.dart';
import '../../../personal_information/presentation/widgets/contact_information_widget.dart';

class ProfilePage extends AppStatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    return BlocListener<PersonalInformationCubit, PersonalInformationState>(
      listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
      child: Scaffold(
          appBar: AddAssetHeader(
            title: appLocalizations.profile_tabs_heading,
            considerFirstTime: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: appTheme.outlinedButtonTheme.style!.copyWith(
                      minimumSize:
                          MaterialStateProperty.all(const Size(0, 38))),
                ),
              ),
              child: Column(
                children: [
                  const PersonalInformationWidget(),
                  const Divider(height: 48),
                  const ContactInformationWidget(),
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
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return const LanguageBottomSheet();
                                    });
                              },
                              child: Text(appLocalizations
                                  .profile_changePassword_change))
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
                      Text(
                          appLocalizations.profile_changePassword_text_password,
                          style: textTheme.titleMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations
                                .profile_changePassword_text_password,
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
                              child: Text(appLocalizations
                                  .profile_changePassword_heading))
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
                      context
                          .read<LocalAuthManager>()
                          .setLocalAuth(val, context);
                    },
                    title: Text(
                        appLocalizations.profile_localAuth_enableFaceId),
                  )
                  /*const Divider(height: 48),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Account", style: textTheme.titleMedium),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Linked account",
                                style: textTheme.bodyMedium!.apply(
                                    color: textTheme.bodyLarge!.color!),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: appTheme.primaryColor,
                              )
                            ],
                          ),
                        ),
                      ]
                          .map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: e,
                              ))
                          .toList(),
                    ),*/
                ],
              ),
            ),
          )),
    );
  }
}
