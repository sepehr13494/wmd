import '../../domain/entities/get_pie_entity.dart';

class GetPieResponse extends GetPieEntity {
  const GetPieResponse({
    required String name,
    required double value,
    required double percentage,
  }) : super(
          name: name,
          value: value,
          percentage: percentage,
        );

  factory GetPieResponse.fromJson(Map<String, dynamic> json) => GetPieResponse(
        name: json["name"],
        value: json["value"].toDouble(),
        percentage: json["percentage"].toDouble(),
      );
}
