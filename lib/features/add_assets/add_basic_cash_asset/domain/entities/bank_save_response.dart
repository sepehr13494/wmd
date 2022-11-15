import 'package:equatable/equatable.dart';

class BankSaveResponse extends Equatable {
  const BankSaveResponse({
    required this.currencyCode,
    required this.currencyRate,
    required this.startingBalance,
    required this.totalNetWorthChange,
    required this.totalNetWorth,
  });

  final String currencyCode;
  final double currencyRate;
  final double startingBalance;
  final double totalNetWorthChange;
  final double totalNetWorth;

  @override
  List<Object?> get props => [
        currencyCode,
        currencyRate,
        startingBalance,
        totalNetWorthChange,
        totalNetWorth
      ];
}
