import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/blurred_widget/data/models/set_blurred_params.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

import '../manager/blurred_privacy_cubit.dart';

class PrivacyToggle extends StatelessWidget {
  const PrivacyToggle({super.key});

  @override
  Widget build(BuildContext context) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;
    return IconButton(
        onPressed: () {
          context
              .read<BlurredPrivacyCubit>()
              .setBlurred(SetBlurredParams(isBlurred: !isBlurred));
        },
        icon: const Icon(Icons.privacy_tip));
  }
}
