class AccountType {
  final String name;
  final String value;

  AccountType({required this.name, required this.value});

  static const json = [
    {"value": "SavingAccount", "name": "Savings account"},
    {"value": "CurrentAccount", "name": "Current account"},
    {"value": "TermDeposit", "name": "Term deposit"},
  ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory AccountType.fromJson(Map<String, dynamic> json) => AccountType(
        value: json["value"],
        name: json["name"],
      );

  static final accountList = json.map((e) => AccountType.fromJson(e)).toList();
}
