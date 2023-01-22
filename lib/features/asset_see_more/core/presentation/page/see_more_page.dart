import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_params.dart';
import 'package:wmd/features/asset_see_more/other_asset/data/model/other_asset_more_entity.dart';
import 'package:wmd/features/asset_see_more/other_asset/presentation/page/other_asset_detail_page.dart';
import 'package:wmd/features/asset_see_more/real_estate/data/model/real_estate_more_entity.dart';
import 'package:wmd/features/asset_see_more/real_estate/presentation/page/real_estate_detail_page.dart';
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
            if (state is GetSeeMoreLoaded) {
              switch (type) {
                case AssetTypes.otherAsset:
                  return OtherAssetDetailPage(
                      entity:
                          state.getAssetSeeMoreEntity as OtherAseetMoreEntity);
                case AssetTypes.realEstate:
                  return RealEstateDetailPage(
                      entity:
                          state.getAssetSeeMoreEntity as RealEstateMoreEntity);
                // case AssetTypes.bankAccount:

                default:
                  return Text('Type:$type  => $state');
              }
            } else {
              return const LoadingWidget();
            }
          }),
    );
  }
}
