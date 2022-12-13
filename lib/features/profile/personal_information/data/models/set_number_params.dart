import 'package:equatable/equatable.dart';

class SetNumberParams extends Equatable{

    const SetNumberParams({
        required this.countryCode,
        required this.phoneNumber,
    });

    final String countryCode;
    final String phoneNumber;

    factory SetNumberParams.fromJson(Map<String, dynamic> json) => SetNumberParams(
        countryCode: json["CountryCode"],
        phoneNumber: json["PhoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "CountryCode": countryCode,
        "PhoneNumber": phoneNumber,
    };

    @override
    List<Object?> get props => [
        countryCode,
        phoneNumber,
    ];
}
    