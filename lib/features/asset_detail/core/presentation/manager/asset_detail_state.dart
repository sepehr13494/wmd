part of 'asset_detail_cubit.dart';

abstract class AssetDetailState {}

class AssetLoaded extends AssetDetailState {
  final GetDetailEntity assetDetailEntity;

  AssetLoaded(this.assetDetailEntity);
}
