part of 'bank_list_cubit.dart';

abstract class BankListState {}

class GetBankListInitial extends BankListState {}

class BankListSuccess extends BankListState {
  final List<BankEntity> banks;

  BankListSuccess(this.banks);
}

class PopularBankListSuccess extends BankListState {
  final List<BankEntity> banks;

  PopularBankListSuccess(this.banks);
}

class MarketDataSuccess extends BankListState {
  final List<ListedSecurityName> entity;
  final String query;

  MarketDataSuccess(this.entity, this.query);
}
