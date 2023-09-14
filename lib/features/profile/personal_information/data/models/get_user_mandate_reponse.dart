import 'package:wmd/features/profile/personal_information/domain/entities/user_mandata_entity.dart';

class GetUserMandateResponse extends UserMandateEntity {
  const GetUserMandateResponse({
    required super.mandateId,
    required super.dataSource,
    required super.syncStatus,
  });

  factory GetUserMandateResponse.fromJson(Map<String, dynamic> json) =>
      GetUserMandateResponse(
        mandateId: json["mandateId"].toString(),
        dataSource: json["dataSource"].toString(),
        syncStatus: json["synced"].toString(),
      );

  // static final tResponse = [GetAllValuationResponse()];
}
