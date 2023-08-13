import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_auth_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_auth_status_modal.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class CustodianMoreBottomSheet extends AppStatelessWidget {
  final String bankId;
  final String? id;
  const CustodianMoreBottomSheet(
      {Key? key, required this.bankId, required this.id})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return sl<CustodianBankAuthCubit>();
            },
          ),
          BlocProvider(
            create: (context) {
              return sl<CustodianStatusListCubit>();
            },
          ),
        ],
        child: BlocConsumer<CustodianBankAuthCubit, CustodianBankAuthState>(
            listener: (context, state) {
          if (state is SuccessState) {
            context.read<CustodianStatusListCubit>().getCustodianStatusList();

            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return SizedBox(
            height: 220,
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: textTheme.titleMedium!.color!.withOpacity(0.3)),
                ),
                SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!
                                      .withOpacity(0.3)),
                              padding: const EdgeInsets.all(4),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                Builder(builder: (context) {
                  return BlocConsumer<CustodianStatusListCubit,
                      CustodianStatusListState>(
                    listener: BlocHelper.defaultBlocListener(
                        listener: ((context, state) {})),
                    builder: (context, state) {
                      List<Map<String, dynamic>> dataList = [
                        {
                          "label": appLocalizations
                              .home_custodianBankList_button_view,
                          "icon": "assets/images/view-eye.svg",
                          "onPress": () async {
                            final resPopup = await showCustodianBankStatus(
                              context: context,
                              bankId: bankId,
                              id: id,
                            );

                            // ignore: use_build_context_synchronously
                            context
                                .read<CustodianStatusListCubit>()
                                .getCustodianStatusList();

                            Navigator.pop(context);
                          }
                        },
                        {
                          "label": appLocalizations
                              .assets_valuationModal_edit_buttons_delete,
                          "icon": "assets/images/trash-can.svg",
                          "onPress": () async {
                            final result = await GlobalFunctions.confirmProcess(
                              icon: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: textTheme.bodySmall!.color!
                                        .withOpacity(0.1)),
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              boldTitle: true,
                              reverse: true,
                              context: context,
                              title: appLocalizations
                                  .linkAccount_deleteCustodianBankModal_title,
                              body: appLocalizations
                                  .linkAccount_deleteCustodianBankModal_description,
                              yes: AppLocalizations.of(context)
                                  .common_button_delete,
                              no: AppLocalizations.of(context)
                                  .common_button_cancel,
                            );

                            debugPrint("result");
                            debugPrint(result.toString());

                            if (result) {
                              context
                                  .read<CustodianBankAuthCubit>()
                                  .deleteCustodianBankStatus(
                                      DeleteCustodianBankStatusParams(id: id));

                              // Navigator.pop(context);
                            }
                          }
                        },
                      ];

                      return ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          Map e = dataList[index];
                          return InkWell(
                            onTap: e["onPress"],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    e["icon"],
                                    height: e["icon"] ==
                                            "assets/images/view-eye.svg"
                                        ? 24
                                        : 16,
                                  ),
                                  SizedBox(
                                      width: e["icon"] ==
                                              "assets/images/view-eye.svg"
                                          ? 10
                                          : 16),
                                  Text(e["label"]),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, _) => const Divider(),
                        itemCount: dataList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      );
                    },
                  );
                })
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: e,
                      ))
                  .toList(),
            ),
          );
        }));
  }
}
