import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/features/profile/preference/data/models/patch_preference_language_params.dart';
import 'package:wmd/features/profile/preference/presentation/manager/preference_cubit.dart';
import 'package:wmd/injection_container.dart';

class LanguagePatcher extends StatefulWidget {
  final Widget child;
  const LanguagePatcher({super.key, required this.child});

  @override
  State<LanguagePatcher> createState() => _LanguagePatcherState();
}

class _LanguagePatcherState extends State<LanguagePatcher> {
  String? ln;
  @override
  Widget build(BuildContext context) {
    final initialLn = context.read<LocalizationManager>().state.languageCode;
    return BlocProvider(
      create: (context) => sl<PreferenceCubit>()..getPreference(),
      child: BlocConsumer<PreferenceCubit, PreferenceState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
        if (state is GetPreferenceLoaded) {
          ln = state.entity.language;
          if (ln != null && initialLn != ln) {
            context.read<LocalizationManager>().switchLanguage();
          }
        }
      }), builder: (context, state) {
        return BlocBuilder<LocalizationManager, Locale>(
            builder: (context, state) {
          // log('Mert log check about patch');
          if (ln != null && ln != state.languageCode) {
            // log('Mert log Will patch to ${state.languageCode}');
            context.read<PreferenceCubit>().patchPreferenceLanguage(
                param: PatchPreferenceLanguageParams(
                    language: state.languageCode));
            ln = null;
          }
          return widget.child;
        });
      }),
    );
  }
}
