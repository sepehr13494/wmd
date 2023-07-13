import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class AddAssetFooter extends AppStatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const AddAssetFooter({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;

    return Container(
      width: double.maxFinite,
      height: 76,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 16,left: 16,bottom: 16),
        child: Row(
          children: [
            isMobile
                ? const SizedBox()
                : Expanded(
                    child: Row(
                      children: [
                        const SupportWidget(),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Center(
                                child: Text(
                          "You can add another asset on the next screen",
                          style: textTheme.bodySmall,
                        ))),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
            ExpandedIf(
              expanded: isMobile,
              child: SizedBox(
                width: isMobile ? double.maxFinite : 300,
                child: Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              try {
                                if (GoRouter.of(context).location ==
                                    "/${AppRoutes.addAssetsView}") {
                                  if (Navigator.of(context).canPop()) {
                                    Navigator.of(context).maybePop();
                                  } else {
                                    context.goNamed(AppRoutes.main);
                                  }
                                } else {
                                  // GlobalFunctions.showExitDialog(
                                  //     context: context,
                                  //     onExitClick: () {
                                  //       if (Navigator.of(context).canPop()) {
                                  //         Navigator.of(context).maybePop();
                                  //       } else {
                                  //         context.goNamed(AppRoutes.main);
                                  //       }
                                  //     });
                                  if (Navigator.of(context).canPop()) {
                                    Navigator.of(context).maybePop();
                                  } else {
                                    context.goNamed(AppRoutes.main);
                                  }
                                }
                              } catch (e) {
                                debugPrint("footer error$e");
                                context.goNamed(AppRoutes.main);
                              }
                            },
                            child: Text(appLocalizations.common_button_back))),
                    const SizedBox(width: 12),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: onTap == null
                                ? null
                                : () {
                                    if (sl<GetUserStatusUseCase>()
                                        .showOnboarding) {
                                      Map<String, dynamic> map = {
                                        "email": sl<GetUserStatusUseCase>()
                                                .userEmail ??
                                            ".",
                                        "loginAt":
                                            DateTime.now().toIso8601String()
                                      };
                                      context
                                          .read<UserStatusCubit>()
                                          .postUserStatus(map: map);
                                    }

                                    onTap!();
                                  },
                            child: Text(buttonText))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
