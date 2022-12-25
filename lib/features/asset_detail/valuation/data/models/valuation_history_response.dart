import '../../domain/entities/valuation_history_entity.dart';

class ValuationHistoryResponse extends ValuationHistoryEntity {
  const ValuationHistoryResponse({required super.date, required super.value});

  factory ValuationHistoryResponse.fromJson(Map<String, dynamic> json) =>
      ValuationHistoryResponse(
          date: DateTime.parse(json['date']),
          value: double.tryParse(json['value'].toString()) ?? 0);

  static final tResponse = [
    ValuationHistoryResponse(date: DateTime.now(), value: 123123)
  ];
}
