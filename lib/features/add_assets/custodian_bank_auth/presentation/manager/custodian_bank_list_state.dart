part of 'custodian_bank_list_cubit.dart';

abstract class CustodianBankListState {}

class CustodianBankListLoaded extends Equatable with CustodianBankListState {
  final List<CustodianBankEntity> custodianBankList;

  CustodianBankListLoaded({
    required this.custodianBankList,
  });

  @override
  List<Object> get props => [
        custodianBankList,
      ];
}
