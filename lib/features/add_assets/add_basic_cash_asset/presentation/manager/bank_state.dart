part of 'bank_cubit.dart';

abstract class BankSaveState {}

class BankDetailInitial extends BankSaveState {}

class BankDetailSaved extends Equatable with BankSaveState {
  final BankSaveResponse bankSaveResponse;

  BankDetailSaved({required this.bankSaveResponse});
  @override
  List<Object?> get props => [bankSaveResponse];
}
