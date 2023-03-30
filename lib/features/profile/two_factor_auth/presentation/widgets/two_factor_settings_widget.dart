import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/injection_container.dart';

class TwoFactorSetting extends AppStatelessWidget {
  const TwoFactorSetting({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocProvider(
        create: (context) => sl<TwoFactorCubit>()..getTwoFactor(),
        child: BlocConsumer<TwoFactorCubit, TwoFactorState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Two-factor authentication",
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      "Two-factor authentication protects your account by adding an extra security step when you sign in.",
                      style: textTheme.bodyMedium,
                    ),
                    if (state is TwoFactorLoaded &&
                        state.entity.emailTwoFactorEnabled)
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[300]),
                          const SizedBox(width: 10),
                          Text(
                            "Enabled for email address",
                            style: textTheme.titleMedium,
                          ),
                        ],
                      ),
                    if (state is TwoFactorLoaded &&
                        state.entity.smsTwoFactorEnabled)
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[300]),
                          const SizedBox(width: 10),
                          Text(
                            "Enabled for mobile phone number",
                            style: textTheme.titleMedium,
                          ),
                        ],
                      ),
                    OutlinedButton(
                        onPressed: () {
                          context.goNamed(AppRoutes.twoFactorAuth);
                        },
                        child: Text("Update 2FA"))
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: e,
                          ))
                      .toList());
            }));
  }
}
