import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/injection_container.dart';

class AuthCheckerPage extends AppStatelessWidget {
  const AuthCheckerPage({super.key});

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<TwoFactorCubit>()..getTwoFactor(),
          ),
        ],
        child: BlocConsumer<TwoFactorCubit, TwoFactorState>(listener:
            BlocHelper.defaultBlocListener(listener: (context, state) {
          if (state is TwoFactorLoaded) {
            if (state.entity.twoFactorEnabled == true) {
              context.goNamed(AppRoutes.verifyOtp);
            } else {
              context.goNamed(AppRoutes.onboarding);
            }
          }
        }), builder: (context, state) {
          return const LoadingWidget();
        }));
  }
}
