import '../../domain/entities/get_force_update_entity.dart';

class GetForceUpdateResponse extends GetForceUpdateEntity {
  const GetForceUpdateResponse({
    required String apiVersion,
    required String appVersion,
  }) : super(
          apiVersion: apiVersion,
          appVersion: appVersion,
        );

  factory GetForceUpdateResponse.fromJson(Map<String, dynamic> json) =>
      GetForceUpdateResponse(
        apiVersion: json["apiVersion"] ?? "",
        appVersion: json["appVersion"] ?? "",
      );

  static const tResponse = GetForceUpdateResponse(
    apiVersion: "1.1.0",appVersion: "2.0"
  );
}
