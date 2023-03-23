import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_settings_params.dart';
import '../entities/get_settings_entity.dart';
import '../../data/models/put_settings_params.dart';
import '../entities/put_settings_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, GetSettingsEntity>> getSettings(
      GetSettingsParams params);
  Future<Either<Failure, PutSettingsEntity>> putSettings(
      PutSettingsParams params);
}
