import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/verify_email/presentation/manager/verify_email_cubit.dart';
import 'package:wmd/injection_container.dart';

class VerifyResponsePage extends AppStatelessWidget {
  final Map<String, dynamic> verifyMap;

  const VerifyResponsePage({Key? key, required this.verifyMap})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    log("verifyMap", error: verifyMap);

    return BlocProvider(
      create: (context) => sl<VerifyEmailCubit>()..verifyEmail(map: verifyMap),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: WidthLimiterWidget(
            child: SingleChildScrollView(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/success.svg",
              height: 70,
            ),
            // Icon(Icons.check_circle, color: Colors.green[300]),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: responsiveHelper.bigger16Gap, horizontal: 15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        appLocalizations
                            .auth_verifyResponse_text_success_heading,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: responsiveHelper.xxLargeFontSize),
                      ),
                      SizedBox(height: responsiveHelper.biggerGap),
                      Text(
                        appLocalizations
                            .auth_verifyResponse_text_success_subheading,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium
                            ?.apply(color: AppColors.dashBoardGreyTextColor),
                      ),
                    ])),
            SizedBox(height: responsiveHelper.biggerGap),
            SizedBox(
                width: 100, // <-- Your width
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.dashboard);
                  },
                  child: Text(
                    appLocalizations.common_button_continue,
                  ),
                ))
          ],
        ))),
      ),
    );
  }
}
