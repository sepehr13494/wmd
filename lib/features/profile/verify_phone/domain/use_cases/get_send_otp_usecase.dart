import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/profile/verify_phone/domain/entities/otp_sent_entity.dart';

import '../../data/models/post_resend_verify_phone_params.dart';

import '../repositories/verify_phone_repository.dart';

class GetSendOtpUseCase extends UseCase<OtpSentEntity, NoParams> {
  final VerifyPhoneRepository repository;
  String identifier = "";

  GetSendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, OtpSentEntity>> call(NoParams params) async {
    final res = await repository.getSendOtp(params);
    cache(res);
    return res;
  }

  void cache(Either<Failure, OtpSentEntity> temp) {
    temp.fold((l) => null, (r) {
      debugPrint("test resend");
      debugPrint(r.toString());
      identifier = r.identifier ?? "";
    });
  }
}
