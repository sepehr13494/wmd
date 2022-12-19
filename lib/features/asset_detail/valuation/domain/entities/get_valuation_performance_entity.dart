import 'package:equatable/equatable.dart';

class GetValuationPerformanceEntity extends Equatable {
  final DateTime date;
  final double value;
  const GetValuationPerformanceEntity(
      {required this.date, required this.value});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [date, value];
}
