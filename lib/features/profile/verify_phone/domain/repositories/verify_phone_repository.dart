import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/profile/verify_phone/domain/entities/otp_sent_entity.dart';

import '../../data/models/post_verify_phone_params.dart';

import '../../data/models/post_resend_verify_phone_params.dart';

abstract class VerifyPhoneRepository {
  Future<Either<Failure, AppSuccess>> postVerifyPhone(
      PostVerifyPhoneParams params);
  Future<Either<Failure, OtpSentEntity>> postResendVerifyPhone(
      PostResendVerifyPhoneParams params);
  Future<Either<Failure, OtpSentEntity>> getSendOtp(NoParams params);
}
