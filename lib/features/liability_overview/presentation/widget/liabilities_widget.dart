import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/liability_overview/domain/entities/get_liablility_overview_entity.dart';

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
              return LiabilitiesPagination(
                liabilities: state.getLiablilityOverviewEntities,
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
