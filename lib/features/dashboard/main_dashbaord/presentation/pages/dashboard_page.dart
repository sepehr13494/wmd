import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../../../core/util/local_storage.dart';

class DashboardPage extends AppStatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: BlocProvider(
        create: (context) => sl<UserStatusCubit>()..getUserStatus(),
        child: WidthLimiterWidget(
          child: BlocConsumer<UserStatusCubit, UserStatusState>(
            listener:
                BlocHelper.defaultBlocListener(listener: (context, state) {
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
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state is UserStatusLoaded &&
                                state.userStatus.loginAt == null
                            ? Text('This is a first time user')
                            : Text('This is a returning user'),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            sl<LocalStorage>().logout();
                            context.goNamed(AppRoutes.splash);
                          },
                          child: Text('Logout'),
                        )
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
