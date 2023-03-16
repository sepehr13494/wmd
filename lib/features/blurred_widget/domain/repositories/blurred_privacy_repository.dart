import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_is_blurred_params.dart';
import '../entities/get_is_blurred_entity.dart';
import '../../data/models/set_blurred_params.dart';
import '../entities/set_blurred_entity.dart';


abstract class BlurredPrivacyRepository {
  Future<Either<Failure, GetIsBlurredEntity>> getIsBlurred(GetIsBlurredParams params);
  Future<Either<Failure, SetBlurredEntity>> setBlurred(SetBlurredParams params);

}
    