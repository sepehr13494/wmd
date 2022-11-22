part of 'real_estate_cubit.dart';

abstract class RealEstateState {}

class RealEstateInitial extends RealEstateState {}

class RealEstateSaved extends Equatable with RealEstateState {
  final AddAsset realEstateSaveResponse;

  RealEstateSaved({required this.realEstateSaveResponse});
  @override
  List<Object?> get props => [realEstateSaveResponse];
}
