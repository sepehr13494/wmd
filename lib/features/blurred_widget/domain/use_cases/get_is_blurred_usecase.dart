import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_is_blurred_params.dart';
import '../entities/is_blurred_entity.dart';
import '../repositories/blurred_privacy_repository.dart';

class GetIsBlurredUseCase extends UseCase<IsBlurredEntity, GetIsBlurredParams> {
  final BlurredPrivacyRepository repository;

  GetIsBlurredUseCase(this.repository);

  @override
  Future<Either<Failure, IsBlurredEntity>> call(GetIsBlurredParams params) =>
      repository.getIsBlurred(params);
}
