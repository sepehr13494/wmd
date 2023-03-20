import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/blurred_widget/data/models/set_blurred_params.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

import '../manager/blurred_privacy_cubit.dart';

class PrivacySwitch extends AppStatelessWidget {
  const PrivacySwitch({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return SwitchListTile.adaptive(
      value: PrivacyInherited.of(context).isBlurred,
      onChanged: (val) {
        context
            .read<BlurredPrivacyCubit>()
            .setBlurred(SetBlurredParams(isBlurred: val));
      },
      title: Text(appLocalizations.profile_tabs_preferences_privacyMode_label),
      subtitle:
          Text(appLocalizations.profile_tabs_preferences_privacyMode_desc),
    );
  }
}
