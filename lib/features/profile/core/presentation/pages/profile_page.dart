import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/profile/personal_information/presentation/widgets/personal_imformation_widget.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/two_factor_settings_widget.dart';

import '../../../personal_information/presentation/manager/personal_information_cubit.dart';
import '../../../personal_information/presentation/widgets/contact_information_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  AppStateAlive<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends AppStateAlive<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<PersonalInformationCubit>().getName();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocListener<PersonalInformationCubit, PersonalInformationState>(
      listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const PersonalInformationWidget(),
            const Divider(height: 48),
            const ContactInformationWidget(),
            const Divider(height: 48),
            const TwoFactorSetting(),
            const Divider(height: 48),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
