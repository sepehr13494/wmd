class RealEstateType {
  final String name;
  final String value;

  RealEstateType({required this.name, required this.value});

  static const json = [
    {"value": "Residential", "name": "Residential"},
    {"value": "Commercial", "name": "Commercial"},
    {"value": "Land", "name": "Land"},
  ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory RealEstateType.fromJson(Map<String, dynamic> json) => RealEstateType(
        value: json["value"],
        name: json["name"],
      );

  static final realEstateList =
      json.map((e) => RealEstateType.fromJson(e)).toList();
}
