import 'package:equatable/equatable.dart';

class AddAsset extends Equatable {
  const AddAsset({
    required this.id,
    required this.currencyCode,
    required this.currencyRate,
    required this.startingBalance,
    required this.totalNetWorthChange,
    required this.totalNetWorth,
  });

  final String id;
  final String currencyCode;
  final double currencyRate;
  final double startingBalance;
  final double totalNetWorthChange;
  final double totalNetWorth;

  @override
  List<Object?> get props => [
        id,
        currencyCode,
        currencyRate,
        startingBalance,
        totalNetWorthChange,
        totalNetWorth
      ];
}
