class ContactReason {
  final String name;
  final String value;

  ContactReason({required this.name, required this.value});

  static const json = [
    {
      "value": "I want to learn more about available investment products",
      "name": "I want to learn more about available investment products"
    },
    {"value": "I have a general inquiry", "name": "I have a general inquiry"},
    {"value": "I need technical support", "name": "I need technical support"},
  ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory ContactReason.fromJson(Map<String, dynamic> json) => ContactReason(
        value: json["value"],
        name: json["name"],
      );

  static final contactReasonList =
      json.map((e) => ContactReason.fromJson(e)).toList();
}
