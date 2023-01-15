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
        name: json["type"]??".",
        value: double.tryParse(json["value"].toString())??0,
        percentage: double.tryParse(json["percentage"].toString())??0,
      );

  static final tResponse = [
    GetPieResponse(name: "testName", percentage: 60, value: 6000),
    GetPieResponse(name: "testName2", percentage: 40, value: 4000),
  ];
}
