import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/search_text_field.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/add_bank_auto/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_bank_auto/presentation/widget/your_privacy.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/injection_container.dart';

class AddBankAutoPage extends AppStatelessWidget {
  const AddBankAutoPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<BankListCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Connect your account")),
        body: SafeArea(
          child: Stack(
            children: [
              const LeafBackground(
                opacity: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 16),
                    Text("Link you bank accounts", style: textTheme.headline6),
                    const SizedBox(height: 8),
                    Text("Search for your bank or select an option below",
                        style: textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SearchTextField(
                      hint: 'Type a bank name',
                      function: (text) {
                        context.read<BankListCubit>().getBankList();
                      },
                    ),
                    BlocConsumer<BankListCubit, BankListState>(
                      listener: BlocHelper.defaultBlocListener(
                          listener: (context, state) {
                        debugPrint(state);
                        // if (state is SuccessState) {
                        //   context.goNamed(AppRoutes.main);
                        // }
                      }),
                      builder: (context, state) {
                        if (state is BankListSuccess) {
                          return Column(
                            children: [
                              ...state.banks
                                  .map((e) => Text(e.toJson().toString()))
                            ],
                          );
                        } else if (state is PopularBankListSuccess) {
                          return Column(
                            children: [
                              Text('Most popular banks'),
                              ...state.banks
                                  .map((e) => Text(e.toJson().toString())),
                            ],
                          );
                        } else if (state is LoadingState) {
                          return CircularProgressIndicator();
                        }
                        return Container();
                      },
                    ),
                    const SupportWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
