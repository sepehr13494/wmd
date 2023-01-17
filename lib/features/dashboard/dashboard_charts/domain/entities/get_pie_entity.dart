import 'package:equatable/equatable.dart';

class GetPieEntity extends Equatable {
  const GetPieEntity({
    required this.name,
    required this.subType,
    required this.value,
    required this.percentage,
  });

  final String name;
  final String? subType;
  final double value;
  final double percentage;

  Map<String, dynamic> toJson() => {
        "type": name,
        "subType": subType,
        "value": value,
        "percentage": percentage,
      };

  @override
  List<Object?> get props => [
        name,
        subType,
        value,
        percentage,
      ];
}
