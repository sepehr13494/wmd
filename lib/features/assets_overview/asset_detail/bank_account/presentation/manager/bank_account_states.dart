part of 'bank_account_cubit.dart';

abstract class BankAccountState {}

class BankAccountLoaded extends Equatable with BankAccountState {
  final BankAccountEntity bankAccount;

  BankAccountLoaded(this.bankAccount);

  @override
  List<Object?> get props => [bankAccount];
}
