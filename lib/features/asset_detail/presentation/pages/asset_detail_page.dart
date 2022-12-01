import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/asset_detail/data/models/get_detail_params.dart';
import 'package:wmd/injection_container.dart';

import '../manager/asset_detail_cubit.dart';

class AssetDetailPage extends AppStatelessWidget {
  final String assetId;
  final String type;
  const AssetDetailPage({Key? key, required this.assetId, required this.type})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset details'),
      ),
      body: BlocProvider(
        create: (context) => sl<AssetDetailCubit>()
          ..getDetail(GetDetailParams(type: type, assetId: assetId)),
        child: BlocConsumer<AssetDetailCubit, AssetDetailState>(
            listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {},
            ),
            builder: (context, state) {
              if (state is AssetLoaded) {
                return Text(state.assetDetailEntity.toString());
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
