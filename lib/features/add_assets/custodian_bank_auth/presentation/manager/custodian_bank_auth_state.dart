part of 'custodian_bank_auth_cubit.dart';

abstract class CustodianBankAuthState {}

class CustodianBankListLoaded extends Equatable with CustodianBankAuthState {
  final List<CustodianBankEntity> getCustodianBankListEntity;

  CustodianBankListLoaded({
    required this.getCustodianBankListEntity,
  });

  @override
  List<Object> get props => [
        getCustodianBankListEntity,
      ];
}
