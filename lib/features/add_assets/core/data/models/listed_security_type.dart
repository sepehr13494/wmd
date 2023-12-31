class ListedSecurityType {
  final String name;
  final String value;

  ListedSecurityType({required this.name, required this.value});

  static const json = [
    {"value": "Equity", "name": "Equity"},
    {"value": "FixedIncome", "name": "Fixed Income"},
    {"value": "ETF", "name": "ETFs"},
    {"value": "MutualFund", "name": "Mutual Funds"},
  ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory ListedSecurityType.fromJson(Map<String, dynamic> json) =>
      ListedSecurityType(
        value: json["value"],
        name: json["name"],
      );

  static final listedSecurityList =
      json.map((e) => ListedSecurityType.fromJson(e)).toList();
}
