import 'package:equatable/equatable.dart';

class GetCurrencyParams extends Equatable {
  const GetCurrencyParams({
    required this.fromCurrency,
    required this.toCurrency,
  });

  final String fromCurrency;
  final String toCurrency;

  factory GetCurrencyParams.fromJson(Map<String, dynamic> json) =>
      GetCurrencyParams(
        fromCurrency: json["fromCurrency"],
        toCurrency: json["toCurrency"],
      );

  Map<String, dynamic> toJson() => {
        "FromCurrency": fromCurrency,
        "ToCurrency": toCurrency,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [fromCurrency, toCurrency];

  static const tParams =
      GetCurrencyParams(fromCurrency: "INR", toCurrency: "USD");
}
