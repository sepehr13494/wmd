class LoanType {
  final String name;
  final String value;

  LoanType({required this.name, required this.value});

  static const json = [
    {"value": "Home Loan", "name": "Home Loan"},
    {"value": "Vehicle Loan", "name": "Vehicle Loan"},
    {"value": "Personal Loan", "name": "Personal Loan"},
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

  factory LoanType.fromJson(Map<String, dynamic> json) => LoanType(
        value: json["value"],
        name: json["name"],
      );

  static final loanList = json.map((e) => LoanType.fromJson(e)).toList();
}
