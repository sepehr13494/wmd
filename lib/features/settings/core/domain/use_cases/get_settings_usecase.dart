import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_settings_params.dart';
import '../entities/get_settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase extends UseCase<GetSettingsEntity, GetSettingsParams> {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);
  @override
  Future<Either<Failure, GetSettingsEntity>> call(GetSettingsParams params) =>
      repository.getSettings(params);
}
