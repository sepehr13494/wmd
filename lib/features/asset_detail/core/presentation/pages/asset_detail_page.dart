import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';
import 'package:wmd/features/asset_detail/listed_asset/domain/entity/listed_asset_entity.dart';
import 'package:wmd/features/asset_detail/listed_asset/presentation/page/listed_asset_page.dart';
import 'package:wmd/features/asset_detail/private_debt/domain/entity/private_debt_entity.dart';
import 'package:wmd/features/asset_detail/private_debt/presentation/page/private_debt_page.dart';
import 'package:wmd/features/asset_detail/private_equity/domain/entity/private_equity_entity.dart';
import 'package:wmd/features/asset_detail/private_equity/presentation/page/private_equity_page.dart';
import 'package:wmd/features/asset_detail/real_estate/domain/entity/real_estate_entity.dart';
import 'package:wmd/features/asset_detail/real_estate/presentation/page/real_estate_page.dart';
import 'package:wmd/injection_container.dart';
import '../manager/asset_detail_cubit.dart';
import '../../../bank_account/presentation/page/bank_account_page.dart';
import '../widgets/valuation_table.dart';

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
      body: Stack(
        children: [
          const LeafBackground(
            opacity: 0.1,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => sl<AssetDetailCubit>()
                    ..getDetail(GetDetailParams(type: type, assetId: assetId)),
                  child: BlocConsumer<AssetDetailCubit, AssetDetailState>(
                      listener: BlocHelper.defaultBlocListener(
                        listener: (context, state) {},
                      ),
                      builder: (context, state) {
                        if (state is AssetLoaded) {
                          switch (type) {
                            case AssetTypes.bankAccount:
                              return BankAccountDetailPage(
                                  bankAccountEntity: state.assetDetailEntity
                                      as BankAccountEntity);
                            case AssetTypes.realEstate:
                              return RealEstateDetailPage(
                                  realEstateEntity: state.assetDetailEntity
                                      as RealEstateEntity);
                            case AssetTypes.listedAsset:
                              return ListedAssetDetailPage(
                                  listedAssetEntity: state.assetDetailEntity
                                      as ListedAssetEntity);
                            case AssetTypes.privateDebt:
                              return PrivateDebtDetailPage(
                                  privateDebtEntity: state.assetDetailEntity
                                      as PrivateDebtEntity);
                            case AssetTypes.privateEquity:
                              return PrivateEquityDetailPage(
                                  privateEquityEntity: state.assetDetailEntity
                                      as PrivateEquityEntity);
                            default:
                              return Text(state.assetDetailEntity.toString());
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                const ValuationWidget(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
