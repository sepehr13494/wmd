import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/blurred_widget/data/models/set_blurred_params.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

import '../manager/blurred_privacy_cubit.dart';

class PrivacySwitch extends StatelessWidget {
  const PrivacySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: PrivacyInherited.of(context).isBlurred,
      onChanged: (val) {
        context
            .read<BlurredPrivacyCubit>()
            .setBlurred(SetBlurredParams(isBlurred: val));
      },
      title: Text("Privacy mode"),
    );
  }
}
