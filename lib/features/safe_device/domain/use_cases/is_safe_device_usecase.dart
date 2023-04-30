import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/safe_device/domain/entities/is_safe_device_entity.dart';

import '../../data/models/is_safe_device_params.dart';

import '../repositories/safe_device_repository.dart';

class IsSafeDeviceUseCase
    extends UseCase<IsSafeDeviceEntity, IsSafeDeviceParams> {
  final SafeDeviceRepository repository;

  IsSafeDeviceUseCase(this.repository);

  @override
  Future<Either<Failure, IsSafeDeviceEntity>> call(IsSafeDeviceParams params) =>
      repository.isSafeDevice(params);
}
