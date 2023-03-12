part of 'valuation_cubit.dart';

abstract class AssetValuationState {}

class PostValuationLoaded extends Equatable with AssetValuationState {
  final PostValuationEntity postValuationEntity;

  PostValuationLoaded({
    required this.postValuationEntity,
  });

  @override
  List<Object?> get props => [
        postValuationEntity,
      ];
}

class UpdateValuationLoaded extends Equatable with AssetValuationState {
  final UpdateValuationEntity updateValuationEntity;

  UpdateValuationLoaded({
    required this.updateValuationEntity,
  });

  @override
  List<Object?> get props => [
        updateValuationEntity,
      ];
}
