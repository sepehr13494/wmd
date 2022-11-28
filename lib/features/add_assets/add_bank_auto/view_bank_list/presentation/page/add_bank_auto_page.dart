import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/search_text_field.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/widget/your_privacy.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/injection_container.dart';

import '../widget/bank_widget.dart';

class AddBankAutoPage extends AppStatelessWidget {
  const AddBankAutoPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect your account")),
      body: Stack(
        children: [
          const LeafBackground(
            opacity: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: NestedScrollView(
              headerSliverBuilder: (context, isInnerScroll) {
                return [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    Text("Add listed asset details",
                        style: textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Text(
                      "Current account, savings account and term deposit accounts.",
                      style: textTheme.titleSmall!
                          .apply(color: AppColors.dashBoardGreyTextColor),
                    ),
                    const SizedBox(height: 16),
                    const YourPrivacyWidget(),
                  ]))
                ];
              },
              body: const BankList(),
            ),
          ),
        ],
      ),
    );
  }
}

class BankList extends AppStatelessWidget {
  const BankList({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<BankListCubit>()..getPopularBankList(),
      child: BlocConsumer<BankListCubit, BankListState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {
          // if (state is something) {
          //  do something
          // }
        }),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text("Link you bank accounts", style: textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text("Search for your bank or select an option below",
                    style: textTheme.titleMedium),
                const SizedBox(height: 8),
                SearchTextField(
                  hint: 'Type a bank name',
                  function: (text) {
                    if (text == null || text.isEmpty) {
                      context.read<BankListCubit>().getPopularBankList();
                    } else {
                      context.read<BankListCubit>().getBankList(text);
                    }
                  },
                ),
                const SizedBox(height: 8),
                Builder(
                  builder: (context) {
                    if (state is BankListSuccess) {
                      if (state.banks.isEmpty) {
                        return Text('No bank found');
                      } else {
                        return Column(
                          children: state.banks
                              .map((e) => BankWidget(e, key: Key(e.code)))
                              .toList(),
                        );
                      }
                    } else if (state is BankListSuccess) {
                      return Column(
                          children: state.banks
                              .map((e) => BankWidget(e, key: Key(e.code)))
                              .toList());
                    } else if (state is PopularBankListSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Most popular banks',
                              style: textTheme.titleMedium,
                            ),
                          ),
                          ...state.banks
                              .map((e) => BankWidget(e, key: Key(e.code))),
                        ],
                      );
                    } else if (state is ErrorState) {
                      return Text(state.failure.message);
                    } else {
                      return Column(
                        children: List.generate(
                            3, (index) => const Card(child: ListTile())),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                const SupportWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
