import 'package:equatable/equatable.dart';

class ValuationHistoryEntity extends Equatable {
  final DateTime date;
  final double value;
  const ValuationHistoryEntity({required this.date, required this.value});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [date, value];
}
