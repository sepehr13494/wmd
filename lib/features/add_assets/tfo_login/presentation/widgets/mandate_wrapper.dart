import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/entities/get_mandate_status_entity.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';
import 'package:wmd/injection_container.dart';

class MandateWrapper extends StatelessWidget {
  final Widget Function(BuildContext, List<GetMandateStatusEntity>) builder;
  const MandateWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MandateStatusCubit>()..getMandateStatus(),
      child: BlocConsumer<MandateStatusCubit, MandateStatusState>(
          listener: BlocHelper.defaultBlocListener(
              listener: (context, mandateState) {}),
          builder: (context, mandateState) {
            List<GetMandateStatusEntity> list = [];
            if (mandateState is GetMandateStatusLoaded) {
              list = List.from(mandateState.getMandateStatusEntities);
            }
            return builder(context, list);
          }),
    );
  }
}
