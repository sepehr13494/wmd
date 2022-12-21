import '../../domain/entities/get_valuation_performance_entity.dart';

class GetValuationPerformanceResponse extends GetValuationPerformanceEntity {
  const GetValuationPerformanceResponse(
      {required super.date, required super.value});

  factory GetValuationPerformanceResponse.fromJson(Map<String, dynamic> json) =>
      GetValuationPerformanceResponse(
          date: DateTime.parse(json['date']),
          value: double.tryParse(json['value'].toString()) ?? 0);

  static final tResponse = [
    GetValuationPerformanceResponse(date: DateTime.now(), value: 123123)
  ];
}
