import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/safe_device/domain/entities/is_safe_device_entity.dart';

import '../models/is_safe_device_params.dart';

import '../../domain/repositories/safe_device_repository.dart';
import '../data_sources/safe_device_local_datasource.dart';

class SafeDeviceRepositoryImpl implements SafeDeviceRepository {
  final SafeDeviceLocalDataSource remoteDataSource;

  SafeDeviceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, IsSafeDeviceEntity>> isSafeDevice(
      IsSafeDeviceParams params) async {
    try {
      final result = await remoteDataSource.isSafeDevice(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
