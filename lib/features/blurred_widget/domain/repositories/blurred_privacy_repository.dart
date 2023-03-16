import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_is_blurred_params.dart';
import '../entities/is_blurred_entity.dart';
import '../../data/models/set_blurred_params.dart';

abstract class BlurredPrivacyRepository {
  Future<Either<Failure, IsBlurredEntity>> getIsBlurred(
      GetIsBlurredParams params);
  Future<Either<Failure, IsBlurredEntity>> setBlurred(SetBlurredParams params);
}
