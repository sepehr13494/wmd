import '../../domain/entities/get_geographic_entity.dart';

class GetGeographicResponse  extends GetGeographicEntity{
    GetGeographicResponse();

    factory GetGeographicResponse.fromJson(Map<String, dynamic> json) => GetGeographicResponse(
    );

    static final tResponse = [GetGeographicResponse()];
}
    