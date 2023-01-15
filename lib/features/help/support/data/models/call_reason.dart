class CallReason {
  final String name;
  final String value;

  CallReason({required this.name, required this.value});

  static final json = [
    {
      "value": "I want to discuss my aggregated portfolio",
      "name": "I want to discuss my aggregated portfolio"
    }
  ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory CallReason.fromJson(Map<String, dynamic> json) => CallReason(
        value: json["value"],
        name: json["name"],
      );

  static final callReasonList =
      json.map((e) => CallReason.fromJson(e)).toList();
}
