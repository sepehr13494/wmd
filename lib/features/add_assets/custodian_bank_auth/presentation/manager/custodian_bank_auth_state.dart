part of 'custodian_bank_auth_cubit.dart';

abstract class CustodianBankAuthState {}

class CustodianBankAuthLoaded extends Equatable with CustodianBankAuthState{
  final GetCustodianBankListEntity getCustodianBankListEntity;
  final PostCustodianBankStatusEntity postCustodianBankStatusEntity;
  final GetCustodianBankStatusEntity getCustodianBankStatusEntity;

  
  CustodianBankAuthLoaded({
    required this.getCustodianBankListEntity,
    required this.postCustodianBankStatusEntity,
    required this.getCustodianBankStatusEntity,

  });

  @override
  List<Object> get props => [
    getCustodianBankListEntity,
    postCustodianBankStatusEntity,
    getCustodianBankStatusEntity,

  ];
}
    