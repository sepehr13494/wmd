import 'package:equatable/equatable.dart';

class GetPieEntity extends Equatable {
  const GetPieEntity({
    required this.name,
    required this.value,
    required this.percentage,
  });

  final String name;
  final double value;
  final double percentage;

  Map<String, dynamic> toJson() => {
        "type": name,
        "value": value,
        "percentage": percentage,
      };

  @override
  List<Object?> get props => [
        name,
        value,
        percentage,
      ];
}
