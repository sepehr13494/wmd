import '../../domain/entities/get_mandate_status_entity.dart';

class GetMandateStatusResponse  extends GetMandateStatusEntity{
    GetMandateStatusResponse();

    factory GetMandateStatusResponse.fromJson(Map<String, dynamic> json) => GetMandateStatusResponse(
    );
    
    static final tResponse = [GetMandateStatusResponse()];
}
    