part of 'private_debt_cubit.dart';

abstract class PrivateDebtState {}

class PrivateDebtInitial extends PrivateDebtState {}

class PrivateDebtSaved extends Equatable with PrivateDebtState {
  final AddAsset privateDebtSaveResponse;

  PrivateDebtSaved({required this.privateDebtSaveResponse});
  @override
  List<Object?> get props => [privateDebtSaveResponse];
}
