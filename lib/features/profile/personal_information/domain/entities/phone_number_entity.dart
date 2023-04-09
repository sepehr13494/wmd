import 'package:equatable/equatable.dart';

class PhoneNumberEntity extends Equatable {
  const PhoneNumberEntity({
    required this.countryCode,
    required this.number,
  });

  final String countryCode;
  final String number;

  factory PhoneNumberEntity.fromJson(Map<String, dynamic> json) =>
      PhoneNumberEntity(
        countryCode: json["countryCode"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "number": number,
      };

  String toNumber() => countryCode + number;
  String toFormattedNumber() => '$countryCode-$number';

  @override
  List<Object?> get props => [
        countryCode,
        number,
      ];
}
