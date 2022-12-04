part of 'loan_liability_cubit.dart';

abstract class LoanLiabilityState {}

class LoanLiabilityInitial extends LoanLiabilityState {}

class LoanLiabilitySaved extends Equatable with LoanLiabilityState {
  final AddAsset loanLiabilitySaveResponse;

  LoanLiabilitySaved({required this.loanLiabilitySaveResponse});
  @override
  List<Object?> get props => [loanLiabilitySaveResponse];
}
