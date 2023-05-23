import '../../domain/entities/get_liablility_overview_entity.dart';

class GetLiabilityOverviewResponse extends GetLiablilityOverviewEntity {
  const GetLiabilityOverviewResponse(
      {required super.name,
      required super.subName,
      required super.current,
      required super.mounthly,
      required super.endDate});

  factory GetLiabilityOverviewResponse.fromJson(Map<String, dynamic> json) =>
      GetLiabilityOverviewResponse(
        current: double.tryParse(json['current']) ?? 0,
        endDate: DateTime.parse(json['endDate']),
        mounthly: double.tryParse(json['mounthly']) ?? 0,
        name: json['name'],
        subName: json['subName'],
      );

  static final tResponse = [
    GetLiabilityOverviewResponse(
      current: 123,
      endDate: DateTime(2017, 9, 7, 17, 30),
      mounthly: 1234,
      name: 'LiabilityName',
      subName: 'Sub name',
    ),
    GetLiabilityOverviewResponse(
      current: 123,
      endDate: DateTime(2017, 9, 7, 17, 30),
      mounthly: 1234,
      name: 'LiabilityName',
      subName: 'Sub name',
    ),
    GetLiabilityOverviewResponse(
      current: 123,
      endDate: DateTime(2017, 9, 7, 17, 30),
      mounthly: 1234,
      name: 'LiabilityName',
      subName: 'Sub name',
    ),
    GetLiabilityOverviewResponse(
      current: 123,
      endDate: DateTime(2017, 9, 7, 17, 30),
      mounthly: 1234,
      name: 'LiabilityName',
      subName: 'Sub name',
    ),
    GetLiabilityOverviewResponse(
      current: 123,
      endDate: DateTime(2017, 9, 7, 17, 30),
      mounthly: 1234,
      name: 'LiabilityName',
      subName: 'Sub name',
    ),
    GetLiabilityOverviewResponse(
      current: 123,
      endDate: DateTime(2017, 9, 7, 17, 30),
      mounthly: 1234,
      name: 'LiabilityName',
      subName: 'Sub name',
    ),
    GetLiabilityOverviewResponse(
      current: 123,
      endDate: DateTime(2017, 9, 7, 17, 30),
      mounthly: 1234,
      name: 'LiabilityName',
      subName: 'Sub name',
    ),
  ];
}
