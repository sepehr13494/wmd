import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_params.dart';
import 'package:wmd/injection_container.dart';

import '../manager/asset_see_more_cubit.dart';

class SeeMorePage extends AppStatelessWidget {
  final String id;
  final String type;
  const SeeMorePage({
    super.key,
    required this.id,
    required this.type,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocProvider(
      create: (context) => sl<AssetSeeMoreCubit>()
        ..getAssetSeeMore(GetSeeMoreParams(type: type, assetId: id)),
      child: BlocConsumer<AssetSeeMoreCubit, AssetSeeMoreState>(
          listener: BlocHelper.defaultBlocListener(
            listener: (context, state) {},
          ),
          builder: (context, state) {
            return Text(state.toString());
          }),
    );
  }
}
