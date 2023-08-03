import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeetingType {
  final String name;
  final String value;

  MeetingType({required this.name, required this.value});

  static List<Map<String, dynamic>> json(context) => [
        {
          "value": "Virtual Meeting",
          "name": AppLocalizations.of(context)
              .scheduleMeeting_meetingType_options_virtualMeeting
        },
        {
          "value": "Video Conference",
          "name": AppLocalizations.of(context)
              .scheduleMeeting_meetingType_options_videoConference
        },
        {
          "value": "Phone Call",
          "name": AppLocalizations.of(context)
              .scheduleMeeting_meetingType_options_call
        },
      ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory MeetingType.fromJson(Map<String, dynamic> json) => MeetingType(
        value: json["value"],
        name: json["name"],
      );

  static List<MeetingType> meetingTypeList(context) =>
      json(context).map((e) => MeetingType.fromJson(e)).toList();
}
