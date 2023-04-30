import '../../domain/entities/is_safe_device_entity.dart';

class IsSafeDeviceResponse extends IsSafeDeviceEntity {
  const IsSafeDeviceResponse(super.isSafe, {super.isAndroid, super.isIOS});
  // IsSafeDeviceResponse();

  static const tResponse = IsSafeDeviceResponse(false);
}
