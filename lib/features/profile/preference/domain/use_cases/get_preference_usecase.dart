import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_preference_params.dart';
import '../entities/get_preference_entity.dart';
import '../repositories/preference_repository.dart';

class GetPreferenceUseCase extends UseCase<GetPreferenceEntity, GetPreferenceParams> {
  final PreferenceRepository repository;

  GetPreferenceUseCase(this.repository);
  
  @override
  Future<Either<Failure, GetPreferenceEntity>> call(GetPreferenceParams params) =>
      repository.getPreference(params);
}
      

    