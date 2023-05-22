import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

import '../../../../injection_container.dart';
import '../manager/liablility_overview_cubit.dart';

class LiabilityList extends AppStatelessWidget {
  const LiabilityList({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocProvider(
      create: (context) =>
          sl<LiabilityOverviewCubit>()..getLiablilityOverview(),
      child: BlocConsumer<LiabilityOverviewCubit, LiablilityOverviewState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
        log('Mert log: $state');
      }), builder: (context, state) {
        return Text(state.toString());
      }),
    );
  }
}
