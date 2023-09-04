import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/settings/core/data/models/get_settings_params.dart';
import 'package:wmd/features/settings/core/data/models/get_settings_response.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';

abstract class DontShowSettingsRepository {
  Future<Either<Failure, AppSuccess>> putSettings(PutSettingsParams params);
  Future<Either<Failure, GetSettingsResponse>> getSettings(
      GetSettingsParams params);
}
