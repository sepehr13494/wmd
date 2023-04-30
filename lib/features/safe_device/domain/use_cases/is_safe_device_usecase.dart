import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/is_safe_device_params.dart';

import '../repositories/safe_device_repository.dart';

class IsSafeDeviceUseCase extends UseCase<AppSuccess, IsSafeDeviceParams> {
  final SafeDeviceRepository repository;

  IsSafeDeviceUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(IsSafeDeviceParams params) =>
      repository.isSafeDevice(params);
}
      

    