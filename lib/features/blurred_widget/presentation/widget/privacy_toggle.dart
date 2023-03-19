import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/blurred_widget/data/models/set_blurred_params.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

import '../manager/blurred_privacy_cubit.dart';

class PrivacyToggle extends StatefulWidget {
  const PrivacyToggle({super.key});

  @override
  State<PrivacyToggle> createState() => _PrivacyToggleState();
}

class _PrivacyToggleState extends State<PrivacyToggle> {
  late final BlurredPrivacyCubit bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<BlurredPrivacyCubit>();
  }

  @override
  Widget build(BuildContext context) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;
    return IconButton(
        onPressed: () {
          bloc.setBlurred(SetBlurredParams(isBlurred: !isBlurred));
        },
        icon: Icon(
            isBlurred ? Icons.remove_red_eye_outlined : Icons.privacy_tip));
  }
}
