import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/repositories/general_inquiry_repository.dart';

class PostGeneralInquiryUseCase
    extends UseCase<AppSuccess, Map<String, dynamic>> {
  final GeneralInquiryRepository generalInquiryRepository;

  PostGeneralInquiryUseCase(this.generalInquiryRepository);
  @override
  Future<Either<Failure, AppSuccess>> call(Map<String, dynamic> params) async {
    try {
      final postParams = GeneralInquiryParams.fromJson(
          {...params, "reason": params["reason"]});

      return await generalInquiryRepository.postGeneralInquiry(postParams);
    } catch (e) {
      debugPrint("PostGeneralInquiryUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}

class GeneralInquiryParams extends Equatable {
  const GeneralInquiryParams({
    required this.reason,
    required this.enquiryText,
  });

  final String reason;
  final String enquiryText;

  factory GeneralInquiryParams.fromJson(Map<String, dynamic> json) =>
      GeneralInquiryParams(
        reason: json["reason"],
        enquiryText: json["enquiryText"],
      );

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "enquiryText": enquiryText,
      };

  static final tGeneralInquiryMap = {
    "reason": "reason",
    "enquiryText": "enquiryText",
  };

  static const tGeneralInquiryParams = GeneralInquiryParams(
    reason: "reason",
    enquiryText: "enquiryText",
  );

  @override
  List<Object?> get props => [
        reason,
        enquiryText,
      ];
}
