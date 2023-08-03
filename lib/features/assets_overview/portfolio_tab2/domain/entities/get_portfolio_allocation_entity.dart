import 'package:equatable/equatable.dart';

class GetPortfolioAllocationEntity extends Equatable {
    final String portfolioName;
    final double value;
    final double percentage;

    const GetPortfolioAllocationEntity({
        required this.portfolioName,
        required this.value,
        required this.percentage,
    });

    Map<String, dynamic> toJson() => {
        "portfolioName": portfolioName,
        "value": value,
        "percentage": percentage,
    };

    @override
    List<Object?> get props => [
        portfolioName,
        value,
        percentage,
    ];
}
    