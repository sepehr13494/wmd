import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/custodian_bank_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_auth_status_modal.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';
import 'package:wmd/injection_container.dart';

class CustodianBankWidgetV2 extends AppStatelessWidget {
  const CustodianBankWidgetV2(
      {super.key,
      required this.bank,
      required this.isSelected,
      required this.onActive});
  final CustodianBankEntity bank;
  final bool isSelected;
  final void Function() onActive;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;

    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        color: isSelected ? primaryColor.withOpacity(0.2) : null,
        child: ListTile(
          onTap: () {
            onActive();
          },
          title: Text(bank.bankName),
          leading: Icon(Icons.account_balance, color: primaryColor),
          trailing: !isSelected
              ? null
              : Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () async {
                        await AnalyticsUtils.triggerEvent(
                            action:
                                AnalyticsUtils.linkBankAction(bank.bankName),
                            params:
                                AnalyticsUtils.linkBankEvent(bank.bankName));

                        await showCustodianBankStatus(
                          context: context,
                          bankId: bank.bankId,
                          id: null,
                          onOk: () {
                            if (sl<GetUserStatusUseCase>().showOnboarding) {
                              sl<GetUserStatusUseCase>().showOnboarding = false;
                              Map<String, dynamic> map = {
                                "email":
                                    sl<GetUserStatusUseCase>().userEmail ?? ".",
                                "loginAt": DateTime.now().toIso8601String()
                              };
                              context
                                  .read<UserStatusCubit>()
                                  .postUserStatus(map: map);
                            }

                            context
                                .read<CustodianStatusListCubit>()
                                .getCustodianStatusList();
                            context.goNamed(AppRoutes.main,
                                queryParams: {'expandCustodian': "true"});

                            context.read<MainPageCubit>().onItemTapped(0);
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Text(appLocalizations.common_button_connect),
                        ),
                      ),
                    );
                  },
                ),
          selected: isSelected,
          selectedColor: null,
        ),
      ),
    );
  }
}
