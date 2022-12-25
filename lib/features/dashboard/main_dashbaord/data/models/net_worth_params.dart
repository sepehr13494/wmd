import 'package:equatable/equatable.dart';

class NetWorthParams extends Equatable{
  const NetWorthParams({
    this.from,
    this.to,
  });

  final DateTime? from;
  final DateTime? to;

  factory NetWorthParams.fromJson(Map<String, dynamic> json) => NetWorthParams(
    from: json["from"] == null ? null : DateTime.parse(json["from"]),
    to: json["to"] == null ? null : DateTime.parse(json["to"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from == null ? null : from!.toIso8601String(),
    "to": to == null ? null : to!.toIso8601String(),
  };

  static NetWorthParams tNetWorthParams = NetWorthParams(from: DateTime(2022,6,5),to: DateTime(2022,7,5));

  @override
  List<Object?> get props => [from,to];
}