import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/features/profile/preference/data/models/patch_preference_language_params.dart';
import 'package:wmd/features/profile/preference/presentation/manager/preference_cubit.dart';
import 'package:wmd/injection_container.dart';

class LanguagePatcher extends StatelessWidget {
  final Widget child;
  const LanguagePatcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ln = context.read<LocalizationManager>().state.languageCode;
    return BlocProvider(
      create: (context) => sl<PreferenceCubit>()
        ..patchPreferenceLanguage(
            param: PatchPreferenceLanguageParams(language: ln)),
      child: BlocConsumer<PreferenceCubit, PreferenceState>(
          listener:
              BlocHelper.defaultBlocListener(listener: (context, state) {}),
          builder: (context, state) {
            return child;
          }),
    );
  }
}
