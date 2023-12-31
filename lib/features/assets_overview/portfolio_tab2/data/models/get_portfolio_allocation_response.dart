import '../../domain/entities/get_portfolio_allocation_entity.dart';

class GetPortfolioAllocationResponse extends GetPortfolioAllocationEntity {
  const GetPortfolioAllocationResponse({
    required String portfolioName,
    required double value,
    required double percentage,
  }) : super(
          portfolioName: portfolioName,
          value: value,
          percentage: percentage,
        );

  factory GetPortfolioAllocationResponse.fromJson(Map<String, dynamic> json) =>
      GetPortfolioAllocationResponse(
        portfolioName: json["portfolioName"] ?? "",
        value: double.tryParse((json["value"]??0).toString()) ?? 0,
        percentage:double.tryParse((json["percentage"]??0).toString()) ?? 0,
      );

  static final tResponse = [
    GetPortfolioAllocationResponse.fromJson(
      const {"portfolioName": "string", "value": 150, "percentage": 15},
    ),
    GetPortfolioAllocationResponse.fromJson(
      const {"portfolioName": "string2", "value": 350, "percentage": 35},
    ),
    GetPortfolioAllocationResponse.fromJson(
      const {"portfolioName": "string3", "value": 500, "percentage": 50},
    )
  ];
}
