class OtherAssetType {
  final String name;
  final String value;

  OtherAssetType({required this.name, required this.value});

  static const json = [
    {"value": "Automobile", "name": "Automobile"},
    {"value": "Yacht", "name": "Yacht"},
    {"value": "Private Jet", "name": "Private Jet"},
    {"value": "Watch", "name": "Watch"},
    {"value": "Painting", "name": "Painting"},
    {"value": "Jewelry", "name": "Jewelry"},
    {"value": "Other", "name": "Other"},
  ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory OtherAssetType.fromJson(Map<String, dynamic> json) => OtherAssetType(
        value: json["value"],
        name: json["name"],
      );

  static final otherAssetList =
      json.map((e) => OtherAssetType.fromJson(e)).toList();
}
