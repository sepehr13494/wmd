import '../../domain/entities/get_liablility_overview_entity.dart';

class GetLiabilityOverviewResponse extends GetLiablilityOverviewEntity {
  GetLiabilityOverviewResponse();

  factory GetLiabilityOverviewResponse.fromJson(Map<String, dynamic> json) =>
      GetLiabilityOverviewResponse();

  static final tResponse = [GetLiabilityOverviewResponse()];
}
