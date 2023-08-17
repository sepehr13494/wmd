import 'package:equatable/equatable.dart';

class GetPortfolioTabParams extends Equatable{
    final String portfolioId;
    final String ownerId;

    const GetPortfolioTabParams({
        required this.portfolioId,
        required this.ownerId,
    });

    factory GetPortfolioTabParams.fromJson(Map<String, dynamic> json) => GetPortfolioTabParams(
        portfolioId: json["portfolioId"],
        ownerId: json["ownerId"],
    );

    Map<String, dynamic> toJson() => {
        "portfolioId": portfolioId,
        "ownerId": ownerId,
    };

    @override
    List<Object?> get props => [
        portfolioId,
        ownerId,
    ];

    static const tParams = GetPortfolioTabParams(ownerId: "ownerId",portfolioId: "portfolioId");
}
    