part of 'bank_list_cubit.dart';

abstract class BankListState {}

class GetBankListInitial extends BankListState {}

class BankListSuccess extends BankListState {
  final List<BankResponse> banks;

  BankListSuccess(this.banks);
}

class PopularBankListSuccess extends BankListState {
  final List<BankResponse> banks;

  PopularBankListSuccess(this.banks);
}
