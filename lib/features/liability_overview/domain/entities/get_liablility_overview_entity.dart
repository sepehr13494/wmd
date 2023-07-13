import 'package:equatable/equatable.dart';

class GetLiablilityOverviewEntity extends Equatable {
  final String name;
  final String subName;
  final double current;
  final double mounthly;
  final DateTime endDate;

  const GetLiablilityOverviewEntity(
      {required this.name,
      required this.subName,
      required this.current,
      required this.mounthly,
      required this.endDate});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];
}
