import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/entities/get_mandate_status_entity.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';
import 'package:wmd/features/settings/linked_accounts/domain/entities/get_linked_accounts_entity.dart';
import 'package:wmd/injection_container.dart';
import '../manager/linked_accounts_cubit.dart';
import '../widget/mobile_view.dart';
import '../widget/tablet_view.dart';

class LinkedAccountsPage extends StatefulWidget {
  const LinkedAccountsPage({super.key});

  @override
  AppState<LinkedAccountsPage> createState() => _LinkedAccountsPageState();
}

class _LinkedAccountsPageState extends AppState<LinkedAccountsPage> {
  bool isFiveOnly = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    final isMobile = ResponsiveHelper(context: context).isMobile;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(appLocalizations, textTheme, context, primaryColor),
            const SizedBox(height: 8),
            BlocProvider(
              create: (context) => sl<MandateStatusCubit>()..getMandateStatus(),
              child: BlocConsumer<MandateStatusCubit, MandateStatusState>(
                  listener: BlocHelper.defaultBlocListener(
                      listener: (context, mandateState) {}),
                  builder: (context, mandateState) {
                    List<GetMandateStatusEntity> mandateList = [];
                    if (mandateState is GetMandateStatusLoaded) {
                      mandateList = List.from(mandateState
                          .getMandateStatusEntities
                          .where((e) => e.synced));
                    }
                    return BlocProvider<LinkedAccountsCubit>(
                      create: (context) =>
                          sl<LinkedAccountsCubit>()..getLinkedAccounts(),
                      child: BlocConsumer<LinkedAccountsCubit,
                              LinkedAccountsState>(
                          listener: BlocHelper.defaultBlocListener(
                              listener: (context, state) {}),
                          builder: (context, state) {
                            List<GetLinkedAccountsEntity> bankValues = [];

                            if (state is GetLinkedAccountsLoaded) {
                              List<GetLinkedAccountsEntity> values =
                                  state.getLinkedAccountsEntities;
                              if (isFiveOnly) {
                                if (values.length > 5 - mandateList.length) {
                                  bankValues = List.from(values.sublist(
                                      values.length - 5 + mandateList.length,
                                      values.length));
                                }
                              }
                            }

                            return isMobile
                                ? LinkedTableMobile(
                                    getLinkedAccountsEntities: bankValues,
                                    mandateList: mandateList,
                                  )
                                : LinkedTableTablet(
                                    getLinkedAccountsEntities: bankValues,
                                    mandateList: mandateList,
                                  );
                          }),
                    );
                  }),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.addAssetsView,
                        queryParams: {'initial': '2'});
                  },
                  child: Text(
                      appLocalizations.profile_linkedAccounts_buttons_link),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildHeader(AppLocalizations appLocalizations, TextTheme textTheme,
      BuildContext context, Color primaryColor) {
    final filters = [
      appLocalizations.profile_linkedAccounts_showAll,
      appLocalizations.profile_linkedAccounts_show5,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.profile_tabs_linkedAccounts_name,
          style: textTheme.headlineSmall,
        ),
        if (ResponsiveHelper(context: context).isMobile)
          const SizedBox(width: 8)
        else
          const Expanded(child: SizedBox(width: 8)),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: [
                    ...filters.map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: textTheme.bodyMedium!,
                            softWrap: true,
                            maxLines: 2,
                            // textTheme.bodyMedium!.toLinkStyle(context),
                          ),
                        )),
                  ],
                  onChanged: ((value) async {
                    if (value == filters[1]) {
                      setState(() {
                        isFiveOnly = true;
                      });
                    } else {
                      setState(() {
                        isFiveOnly = false;
                      });
                    }
                  }),
                  value: isFiveOnly ? filters[1] : filters.first,
                  isExpanded: true,
                  itemHeight: null,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 15,
                    color: primaryColor,
                  ),
                  // style: textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
