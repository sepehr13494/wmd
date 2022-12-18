import 'package:equatable/equatable.dart';

class GetGeographicEntity extends Equatable {
    const GetGeographicEntity({
        required this.continent,
        required this.amount,
        required this.percentage,
    });

    final String continent;
    final double amount;
    final double percentage;

    Map<String, dynamic> toJson() => {
        "continent": continent,
        "amount": amount,
        "percentage": percentage,
    };

    @override
    List<Object?> get props => [
        continent,
        amount,
        percentage,
    ];
}
    