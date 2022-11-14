class NetWorthParams {
  NetWorthParams({
    this.from,
    this.to,
  });

  DateTime? from;
  DateTime? to;

  factory NetWorthParams.fromJson(Map<String, dynamic> json) => NetWorthParams(
    from: json["from"] == null ? null : DateTime.parse(json["from"]),
    to: json["to"] == null ? null : DateTime.parse(json["to"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from == null ? null : from!.toIso8601String(),
    "to": to == null ? null : to!.toIso8601String(),
  };
}