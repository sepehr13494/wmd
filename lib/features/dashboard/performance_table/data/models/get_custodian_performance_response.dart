import '../../domain/entities/get_custodian_performance_entity.dart';

class GetCustodianPerformanceResponse extends GetCustodianPerformanceEntity {
  const GetCustodianPerformanceResponse({
    required String serialNumber,
    required String custodianName,
    double? performance,
    double? amount,
    double? riskPa,
    double? sharpeRatio,
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
        serialNumber: json["serialNumber"]??"",
        custodianName: json["custodianName"]??"",
        performance: json["performance"] == null ? null :  double.tryParse((json["performance"]??"0").toString())??0,
        amount: json["amount"] == null ? null :  double.tryParse((json["amount"]??"0").toString())??0,
        riskPa: json["riskPa"] == null ? null :  double.tryParse((json["riskPA"]??"0").toString())??0,
        sharpeRatio: json["sharpeRatio"] == null ? null :  double.tryParse((json["sharpeRatio"]??"0").toString())??0,
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
