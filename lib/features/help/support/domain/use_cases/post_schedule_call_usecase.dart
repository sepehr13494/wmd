import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/help/support/domain/repositories/schedule_call_repository.dart';

class PostScheduleCallUseCase
    extends UseCase<AppSuccess, Map<String, dynamic>> {
  final ScheduleCallRepository scheduleCallRepository;

  PostScheduleCallUseCase(this.scheduleCallRepository);
  @override
  Future<Either<Failure, AppSuccess>> call(Map<String, dynamic> params) async {
    try {
      final postParams = ScheduleCallParams.fromJson(params);

      return await scheduleCallRepository.postScheduleCall(postParams);
    } catch (e) {
      debugPrint("PostScheduleCallUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}

class ScheduleCallParams extends Equatable {
  const ScheduleCallParams({
    required this.reason,
    required this.enquiryText,
  });

  final String reason;
  final String enquiryText;

  factory ScheduleCallParams.fromJson(Map<String, dynamic> json) =>
      ScheduleCallParams(
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

  static const tGeneralInquiryParams = ScheduleCallParams(
    reason: "reason",
    enquiryText: "enquiryText",
  );

  @override
  List<Object?> get props => [
        reason,
        enquiryText,
      ];
}
