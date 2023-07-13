import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/blurred_widget/data/models/set_blurred_params.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_toast.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

import '../manager/blurred_privacy_cubit.dart';

class PrivacySwitch extends AppStatelessWidget {
  const PrivacySwitch({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return SwitchListTile.adaptive(
      value: PrivacyInherited.of(context).isBlurred,
      activeColor: AppColors.primary,
      onChanged: (val) {
        PrivacyToast.showPrivacyModeToast(context, val);
        context
            .read<BlurredPrivacyCubit>()
            .setBlurred(SetBlurredParams(isBlurred: val));

        if (val == true) {
          AnalyticsUtils.triggerEvent(
              action: AnalyticsUtils.privacyOnAction,
              params: AnalyticsUtils.privacyOnEvent);
        } else {
          AnalyticsUtils.triggerEvent(
              action: AnalyticsUtils.privacyOffAction,
              params: AnalyticsUtils.privacyOffEvent);
        }
      },
      title: Text(appLocalizations.profile_tabs_preferences_privacyMode_label),
      subtitle:
          Text(appLocalizations.profile_tabs_preferences_privacyMode_desc),
    );
  }
}
