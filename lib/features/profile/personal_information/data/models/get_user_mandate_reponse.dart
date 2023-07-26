import 'package:wmd/features/profile/personal_information/domain/entities/user_mandata_entity.dart';

class GetUserMandateResponse extends UserMandateEntity {
  const GetUserMandateResponse({
    required super.mandateId,
    required super.dataSource,
    required super.synced,
  });

  factory GetUserMandateResponse.fromJson(Map<String, dynamic> json) =>
      GetUserMandateResponse(
        mandateId: json["mandateId"],
        dataSource: json["dataSource"],
        synced: json["synced"],
      );

  // static final tResponse = [GetAllValuationResponse()];
}
