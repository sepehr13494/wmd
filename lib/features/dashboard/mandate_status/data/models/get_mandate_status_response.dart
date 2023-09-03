import '../../domain/entities/get_mandate_status_entity.dart';

class GetMandateStatusResponse extends GetMandateStatusEntity {
  const GetMandateStatusResponse(
      {required super.mandateId,
      required super.dataSource,
      super.syncDate,
      required super.synced});

  factory GetMandateStatusResponse.fromJson(Map<String, dynamic> json) {
    return GetMandateStatusResponse(
      dataSource: json['dataSource'],
      mandateId: json['mandateId'],
      syncDate:
          json['syncDate'] != null ? DateTime.parse(json['syncDate']) : null,
      synced: json['synced'],
    );
  }

  static final tResponse = [
    GetMandateStatusResponse(
        dataSource: 'adsf',
        mandateId: 1234,
        syncDate: DateTime.now(),
        synced: false)
  ];
}
