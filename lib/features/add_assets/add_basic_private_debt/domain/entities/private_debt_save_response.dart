import 'package:equatable/equatable.dart';

class PrivateDebtSaveResponse extends Equatable {
  const PrivateDebtSaveResponse({
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
