import 'package:equatable/equatable.dart';

class GetManualListEntity extends Equatable{
    final String id;
    final String bankName;
    final String country;
    final String countryIso2;

    const GetManualListEntity({
        required this.id,
        required this.bankName,
        required this.country,
        required this.countryIso2,
    });

    Map<String, dynamic> toJson() => {
        "id": id,
        "bankName": bankName,
        "country": country,
        "countryIso2": countryIso2,
    };

  @override
  List<Object?> get props => [
      id,
      bankName,
      country,
      countryIso2,
  ];
}
