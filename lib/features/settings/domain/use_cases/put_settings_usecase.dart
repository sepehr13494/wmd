import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/put_settings_params.dart';
import '../entities/put_settings_entity.dart';
import '../repositories/settings_repository.dart';

class PutSettingsUseCase extends UseCase<PutSettingsEntity, PutSettingsParams> {
  final SettingsRepository repository;

  PutSettingsUseCase(this.repository);
  
  @override
  Future<Either<Failure, PutSettingsEntity>> call(PutSettingsParams params) =>
      repository.putSettings(params);
}
      

    