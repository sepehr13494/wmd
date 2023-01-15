part of 'asset_summary_cubit.dart';

abstract class AssetSummaryState {}

class AssetLoaded extends AssetSummaryState {
  final AssetSummaryEntitiy assetSummaryEntity;

  AssetLoaded(this.assetSummaryEntity);
}
