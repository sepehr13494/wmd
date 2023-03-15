import '../../domain/entities/get_custodian_performance_entity.dart';

class GetCustodianPerformanceResponse extends GetCustodianPerformanceEntity {
  const GetCustodianPerformanceResponse({
    required String serialNumber,
    required String custodianName,
    required double performance,
    required int amount,
    required int riskPa,
    required double sharpeRatio,
  }) : super(
          serialNumber: serialNumber,
          custodianName: custodianName,
          performance: performance,
          amount: amount,
          riskPa: riskPa,
          sharpeRatio: sharpeRatio,
        );

  factory GetCustodianPerformanceResponse.fromJson(Map<String, dynamic> json) =>
      GetCustodianPerformanceResponse(
        serialNumber: json["serialNumber"],
        custodianName: json["custodianName"],
        performance: json["performance"].toDouble(),
        amount: json["amount"],
        riskPa: json["riskPA"],
        sharpeRatio: json["sharpeRatio"].toDouble(),
      );

  static final tResponse = [
    GetCustodianPerformanceResponse.fromJson(const {
      "serialNumber": "Q1234",
      "custodianName": "Aeigs Capital Corp",
      "performance": 115.06,
      "amount": 100,
      "riskPA": 20,
      "sharpeRatio": 0.23
    })
  ];
}
