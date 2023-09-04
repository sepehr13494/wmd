import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/help/support/domain/repositories/schedule_call_repository.dart';

class PostScheduleCallUseCase
    extends UseCase<AppSuccess, Map<String, dynamic>> {
  final ScheduleCallRepository scheduleCallRepository;

  PostScheduleCallUseCase(this.scheduleCallRepository);
  @override
  Future<Either<Failure, AppSuccess>> call(Map<String, dynamic> params) async {
    try {
      debugPrint(params.toString());

      final startTime = params["time"].split(' - ')[0].split('.')[0];
      final endTime = params["time"].split(' - ')[1].split('.')[0];

      final map = {
        ...params,
        "startTime": params["date"] != null
            ? Jiffy(params["date"].toString())
                .add(hours: int.parse(startTime))
                .dateTime
            : params["date"],
        "endTime": params["date"] != null
            ? Jiffy(params["date"].toString())
                .add(hours: int.parse(endTime))
                .dateTime
            : params["date"],
        "location": params["email"] ?? "",
        "timeZone": params["timeZone"]?.value,
        "subject": params["subject"],
      };

      debugPrint(map.toString());

      final postParams = ScheduleCallParams.fromJson(map);

      return await scheduleCallRepository.postScheduleCall(postParams);
    } catch (e) {
      debugPrint("PostScheduleCallUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}

class ScheduleCallParams extends Equatable {
  const ScheduleCallParams({
    this.contactEmail = AppConstants.contactEmail,
    required this.country,
    required this.subject,
    this.content = "",
    required this.startTime,
    required this.endTime,
    required this.timeZone,
    required this.location,
    this.isOnlineMeeting = true,
    this.firstName,
    this.lastName,
  });

  final String? contactEmail;
  final String country;
  final String subject;
  final String? content;
  final DateTime startTime;
  final DateTime endTime;
  final String timeZone;
  final String location;
  final bool? isOnlineMeeting;
  final String? firstName;
  final String? lastName;

  factory ScheduleCallParams.fromJson(Map<String, dynamic> json) =>
      ScheduleCallParams(
        contactEmail: json["contactEmail"] ?? AppConstants.contactEmail,
        country: (json["country"] as Country).countryName,
        subject: json["subject"],
        content: json["content"] ?? "",
        startTime: json["startTime"],
        endTime: json["endTime"],
        timeZone: json["timeZone"],
        location: json["location"],
        isOnlineMeeting: json["isOnlineMeeting"] ?? true,
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "contactEmail": contactEmail,
        "country": country,
        "subject": subject,
        "content": content,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "timeZone": timeZone,
        "location": location,
        "isOnlineMeeting": isOnlineMeeting,
        "userEmail": location,
        "firstName": firstName,
        "lastName": lastName,
      };

  static final tScheduleCallMap = {
    "contactEmail": "n.albasri@tfoco.com",
    "country": "country",
    "subject": "enquiryText",
    "content": "reason",
    "startTime": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "endTime": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "timeZone": "enquiryText",
    "location": "reason",
    "firstName": "reason",
    "lastName": "reason",
    "isOnlineMeeting": true,
  };

  static final tScheduleCallParams = ScheduleCallParams(
    contactEmail: "n.albasri@tfoco.com",
    country: "country",
    subject: "subject",
    content: "content",
    startTime: DateTime.parse('2022-10-05T21:00:00.000Z'),
    endTime: DateTime.parse('2022-10-05T21:00:00.000Z'),
    timeZone: "timeZone",
    location: "location",
    firstName: "location",
    lastName: "location",
    isOnlineMeeting: true,
  );

  @override
  List<Object?> get props => [
        contactEmail,
        country,
        subject,
        content,
        startTime,
        endTime,
        timeZone,
        location,
        isOnlineMeeting,
        firstName,
        lastName,
      ];
}
