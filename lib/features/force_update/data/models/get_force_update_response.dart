import '../../domain/entities/get_force_update_entity.dart';

class GetForceUpdateResponse extends GetForceUpdateEntity {
  const GetForceUpdateResponse({
    required String apiVersion,
    required String appVersion,
    required bool isForceUpdate,
  }) : super(
          apiVersion: apiVersion,
          appVersion: appVersion,
    isForceUpdate: isForceUpdate,
        );

  factory GetForceUpdateResponse.fromJson(Map<String, dynamic> json) =>
      GetForceUpdateResponse(
        apiVersion: json["apiVersion"] ?? "",
        appVersion: json["appVersion"] ?? "",
        isForceUpdate: json["isForceUpdate"] ?? false,
      );

  static const tResponse = GetForceUpdateResponse(
    apiVersion: "1.1.0",appVersion: "2.0",isForceUpdate: false
  );
}
