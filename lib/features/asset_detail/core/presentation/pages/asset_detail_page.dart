import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';
import 'package:wmd/features/asset_detail/listed_asset/domain/entity/listed_asset_entity.dart';
import 'package:wmd/features/asset_detail/listed_asset/presentation/page/listed_asset_page.dart';
import 'package:wmd/features/asset_detail/real_estate/domain/entity/real_estate_entity.dart';
import 'package:wmd/features/asset_detail/real_estate/presentation/page/real_estate_page.dart';
import 'package:wmd/injection_container.dart';
import '../manager/asset_detail_cubit.dart';
import '../../../bank_account/presentation/page/bank_account_page.dart';

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
                switch (type) {
                  case 'BankAccount':
                    return BankAccountDetailPage(
                        bankAccountEntity:
                            state.assetDetailEntity as BankAccountEntity);
                  case 'RealEstate':
                    return RealEstateDetailPage(
                        realEstateEntity:
                            state.assetDetailEntity as RealEstateEntity);
                  case 'ListedAsset':
                    return ListedAssetDetailPage(
                        listedAssetEntity:
                            state.assetDetailEntity as ListedAssetEntity);
                  default:
                    return Text(state.assetDetailEntity.toString());
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
