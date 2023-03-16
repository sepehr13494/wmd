import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/set_blurred_params.dart';
import '../entities/is_blurred_entity.dart';
import '../repositories/blurred_privacy_repository.dart';

class SetBlurredUseCase extends UseCase<IsBlurredEntity, SetBlurredParams> {
  final BlurredPrivacyRepository repository;

  SetBlurredUseCase(this.repository);

  @override
  Future<Either<Failure, IsBlurredEntity>> call(SetBlurredParams params) =>
      repository.setBlurred(params);
}
