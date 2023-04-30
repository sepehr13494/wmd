import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/safe_device/domain/entities/is_safe_device_entity.dart';
import '../../data/models/is_safe_device_params.dart';

abstract class SafeDeviceRepository {
  Future<Either<Failure, IsSafeDeviceEntity>> isSafeDevice(
      IsSafeDeviceParams params);
}
