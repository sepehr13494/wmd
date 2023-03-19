import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/injection_container.dart';

import '../../../../core/presentation/bloc/bloc_helpers.dart';
import '../manager/blurred_privacy_cubit.dart';

class PrivacyWrapper extends StatelessWidget {
  final Widget child;
  const PrivacyWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlurredPrivacyCubit, BlurredPrivacyState>(
      listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
      builder: (context, state) {
        bool? isBlurred;

        if (state is IsBlurredLoaded) {
          isBlurred = state.isBlurred;
        }

        return PrivacyInherited(
          isBlurred: isBlurred ?? false,
          child: child,
        );
      },
    );
  }
}

class PrivacyInherited extends InheritedWidget {
  const PrivacyInherited({
    super.key,
    required this.isBlurred,
    required super.child,
  });

  final bool isBlurred;

  static PrivacyInherited of(BuildContext context) {
    final PrivacyInherited? result =
        context.dependOnInheritedWidgetOfExactType<PrivacyInherited>();
    assert(result != null, 'No PrivacyInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PrivacyInherited oldWidget) {
    return (isBlurred != oldWidget.isBlurred);
  }
}
