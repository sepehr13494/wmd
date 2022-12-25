import 'package:equatable/equatable.dart';
import 'package:wmd/features/asset_detail/valuation/domain/entities/valuation_history_entity.dart';

class GetValuationPerformanceEntity extends Equatable {
  final double netChange;
  final List<ValuationHistoryEntity> valuationHistory;
  const GetValuationPerformanceEntity(
      {required this.netChange, required this.valuationHistory});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [netChange, valuationHistory];
}
