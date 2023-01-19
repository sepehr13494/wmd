part of 'asset_see_more_cubit.dart';

abstract class AssetSeeMoreState {}

class GetSeeMoreLoaded extends Equatable with AssetSeeMoreState {
  final GetSeeMoreResponse getAssetSeeMoreEntity;

  GetSeeMoreLoaded({
    required this.getAssetSeeMoreEntity,
  });

  @override
  List<Object?> get props => [
        getAssetSeeMoreEntity,
      ];
}
