import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/injection_container.dart';

class TwoFactorSetting extends AppStatelessWidget {
  const TwoFactorSetting({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return BlocConsumer<TwoFactorCubit, TwoFactorState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Text(
                    appLocalizations
                        .profile_twofactorauthentication_page_heading,
                    style: textTheme.headlineSmall,
                  )),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations
                          .profile_twofactorauthentication_page_description,
                      style: textTheme.bodyMedium,
                    ),
                    if (state is TwoFactorLoaded &&
                        state.entity.emailTwoFactorEnabled)
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[300]),
                          const SizedBox(width: 10),
                          Text(
                            appLocalizations
                                .profile_twofactorauthentication_label_enabledEmail,
                            style: textTheme.titleSmall,
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
                            appLocalizations
                                .profile_twofactorauthentication_label_enabledPhoneNumber,
                            style: textTheme.titleSmall,
                          ),
                        ],
                      ),
                    OutlinedButton(
                        onPressed: () {
                          context.goNamed(AppRoutes.twoFactorAuth);
                        },
                        child: Text(appLocalizations
                            .profile_twofactorauthentication_button_change2FA))
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: e,
                          ))
                      .toList())
            ],
          );
        });
  }
}
