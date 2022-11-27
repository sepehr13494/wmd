part of 'other_asset_cubit.dart';

abstract class OtherAssetState {}

class OtherAssetInitial extends OtherAssetState {}

class OtherAssetSaved extends Equatable with OtherAssetState {
  final AddAsset otherAssetSaveResponse;

  OtherAssetSaved({required this.otherAssetSaveResponse});
  @override
  List<Object?> get props => [otherAssetSaveResponse];
}
