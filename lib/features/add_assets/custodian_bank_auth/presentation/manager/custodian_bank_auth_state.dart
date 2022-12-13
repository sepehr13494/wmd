part of 'custodian_bank_auth_cubit.dart';

abstract class CustodianBankAuthState {}

class OngoingCustodianListLoaded extends Equatable with CustodianBankAuthState {
  final List<CustodianBankEntity> ongoingList;

  OngoingCustodianListLoaded({
    required this.ongoingList,
  });

  @override
  List<Object> get props => [
        ongoingList,
      ];
}

class CustodianBankStateLoaded extends Equatable with CustodianBankAuthState {
  final CustodianBankStatusEntity custodianBankStatusEntity;

  CustodianBankStateLoaded({
    required this.custodianBankStatusEntity,
  });

  @override
  List<Object> get props => [
        custodianBankStatusEntity,
      ];
}
