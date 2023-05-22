import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/add_button.dart';

import '../../../../injection_container.dart';
import '../manager/liablility_overview_cubit.dart';
import 'liabilities_list.dart';

class LiabilitiesWidget extends AppStatelessWidget {
  const LiabilitiesWidget({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    // Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocProvider(
      create: (context) =>
          sl<LiabilityOverviewCubit>()..getLiablilityOverview(),
      child: BlocConsumer<LiabilityOverviewCubit, LiablilityOverviewState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {
          log('Mert log: $state');
        }),
        builder: BlocHelper.errorHandlerBlocBuilder(
          hideError: false,
          builder: (context, state) {
            // return Text(state.toString());

            if (state is GetLiabilityOverviewLoaded) {
              return Column(
                children: [
                  const LiabilityHeader(),
                  LiabilitiesPagination(
                    liabilities: state.getLiablilityOverviewEntities,
                  ),
                ],
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}

class LiabilityHeader extends AppStatelessWidget {
  const LiabilityHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Home Loans',
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                1564312.convertMoney(addDollar: true),
                style: textTheme.headlineMedium,
              ),
              AddButtonLiability(onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
