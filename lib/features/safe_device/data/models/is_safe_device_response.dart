import '../../domain/entities/is_safe_device_entity.dart';

class IsSafeDeviceResponse extends IsSafeDeviceEntity {
  const IsSafeDeviceResponse(super.isSafe, {super.isAndroid, super.isIOS});

  factory IsSafeDeviceResponse.fromJson(Map<String, dynamic> json) =>
      IsSafeDeviceResponse(
        json['isSafe'],
        isAndroid: json['isAndroid'],
        isIOS: json['isIOS'],
      );
  static const tResponse = IsSafeDeviceResponse(false);
}
