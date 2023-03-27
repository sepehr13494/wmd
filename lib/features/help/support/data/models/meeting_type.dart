class MeetingType {
  final String name;
  final String value;

  MeetingType({required this.name, required this.value});

  static final json = [
    {"value": "Virtual Meeting", "name": "Virtual Meeting"},
    {"value": "Video Conference", "name": "Video Conference"},
    {"value": "Phone Call", "name": "Phone Call"},
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

  static final meetingTypeList =
      json.map((e) => MeetingType.fromJson(e)).toList();
}
