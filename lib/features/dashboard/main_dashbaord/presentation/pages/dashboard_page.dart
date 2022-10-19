import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/empty_state_dashboard.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../../../core/util/local_storage.dart';

class DashboardPage extends AppStatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: BlocProvider(
        create: (context) => sl<UserStatusCubit>()..getUserStatus(),
        child: BlocConsumer<UserStatusCubit, UserStatusState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
            if (state is UserStatusLoaded) {
              if (state.userStatus.loginAt == null) {
                // !this is the first time user so update last loginAt
                final requestParam = {
                  "email": state.userStatus.email,
                  "loginAt": CustomizableDateTime.currentDate,
                };
                context
                    .read<UserStatusCubit>()
                    .postUserStatus(map: requestParam);
              }
            }
          }),
          builder: (context, state) {
            return LayoutBuilder(builder: (context, snap) {
              return SingleChildScrollView(
                child: Container(
                  padding: responsiveHelper.paddingForMobileTab,
                  decoration: BoxDecoration(
                      color: textTheme.bodySmall!.color!.withOpacity(0.05),
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                  margin: responsiveHelper.marginForMobileTab,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Link all your assets with ease',
                        style: textTheme.headlineSmall!
                            .apply(fontWeightDelta: 4)
                            .copyWith(
                                fontSize: responsiveHelper.getFontSize(30),
                                height: responsiveHelper.getLineHeight(1.2)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Connect with your institutions to see updates for your assets and liabilities',
                        style: textTheme.titleMedium!.copyWith(
                            fontSize: responsiveHelper.getFontSize(20),
                            height: responsiveHelper.getLineHeight(1.2)),
                        textAlign: TextAlign.center,
                      ),
                      // const SizedBox(height: 48),
                      state is UserStatusLoaded &&
                              state.userStatus.loginAt == null
                          ? const Text('This is a first time user')
                          : EmptyStateDashboard(
                              responsiveHelper: responsiveHelper),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed(AppRoutes.addAssetsView);
                          },
                          child: const Text('Get Started'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
