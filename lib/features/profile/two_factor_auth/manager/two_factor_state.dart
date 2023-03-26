part of 'two_factor_cubit.dart';

abstract class TwoFactorState {}

class TwoFactorLoaded extends Equatable with TwoFactorState {
  final GetSettingsEntity entity;

  TwoFactorLoaded({
    required this.entity,
  });

  @override
  List<Object?> get props => [
        entity,
      ];
}
