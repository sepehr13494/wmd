import '../../domain/entities/put_settings_entity.dart';

class PutSettingsResponse extends PutSettingsEntity {
  const PutSettingsResponse();

  factory PutSettingsResponse.fromJson(Map<String, dynamic> json) =>
      const PutSettingsResponse();

  static final tResponse = PutSettingsResponse();
}
