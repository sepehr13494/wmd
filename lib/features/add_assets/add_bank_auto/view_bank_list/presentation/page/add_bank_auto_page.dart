import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
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
      appBar: AppBar(
          title: Text(appLocalizations.linkAccount_automaticLink_page_title)),
      body: Stack(
        children: const [
          LeafBackground(
            opacity: 0.5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ResponsiveWidget(
              mobile: BankListMobileView(),
              desktop: BankListTabletView(),
              tablet: BankListTabletView(),
            ),
          ),
        ],
      ),
    );
  }
}

class BankListMobileView extends AppStatelessWidget {
  const BankListMobileView({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          BankListHeader(),
          BankList(),
        ],
      ),
    );
  }
}

class BankListTabletView extends AppStatelessWidget {
  const BankListTabletView({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 3, child: BankListHeader()),
        const SizedBox(width: 16),
        Container(
          margin: const EdgeInsets.only(top: 24),
          width: 0.5,
          height: 300,
          color: Theme.of(context).dividerColor,
        ),
        const SizedBox(width: 16),
        Expanded(
            flex: ResponsiveHelper(context: context).isDesktop ? 6 : 4,
            child: const BankList())
      ],
    );
  }
}

class BankListHeader extends AppStatelessWidget {
  const BankListHeader({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(appLocalizations.linkAccount_automaticLink_heading,
            style: textTheme.headlineSmall),
        const SizedBox(height: 16),
        Text(
          appLocalizations.linkAccount_automaticLink_description,
          style: textTheme.titleSmall!
              .apply(color: AppColors.dashBoardGreyTextColor),
        ),
        const SizedBox(height: 16),
        const YourPrivacyWidget(),
      ],
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
                Text(appLocalizations.linkAccount_automaticLink_title,
                    style: textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(appLocalizations.linkAccount_automaticLink_label_search,
                    style: textTheme.titleMedium),
                const SizedBox(height: 8),
                SearchTextField(
                  hint: appLocalizations
                      .linkAccount_automaticLink_input_bank_placeholder,
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
                        return Text(appLocalizations
                            .linkAccount_automaticLink_text_notFound);
                      } else {
                        return Column(
                          children: state.banks
                              .map((e) => BankWidget(e, key: Key(e.code)))
                              .toList(),
                        );
                      }
                    } else if (state is PopularBankListSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              appLocalizations
                                  .linkAccount_automaticLink_label_popularBank,
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
