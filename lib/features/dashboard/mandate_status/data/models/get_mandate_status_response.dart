import '../../domain/entities/get_mandate_status_entity.dart';

class GetMandateStatusResponse extends GetMandateStatusEntity {
  const GetMandateStatusResponse(
      {required super.mandateId,
      required super.dataSource,
      required super.synced});

  factory GetMandateStatusResponse.fromJson(Map<String, dynamic> json) {
    return GetMandateStatusResponse(
      dataSource: json['dataSource'],
      mandateId: json['mandateId'],
      synced: json['synced'],
    );
  }

  static final tResponse = [
    const GetMandateStatusResponse(
        dataSource: 'adsf', mandateId: 1234, synced: false)
  ];
}
