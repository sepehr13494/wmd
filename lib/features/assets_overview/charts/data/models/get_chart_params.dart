import 'package:equatable/equatable.dart';

class GetChartParams extends Equatable {
  const GetChartParams({
    required this.userid,
    required this.to,
    required this.from,
  });

  final String userid;
  final String to;
  final String from;

  factory GetChartParams.fromJson(Map<String, dynamic> json) => GetChartParams(
        userid: json["userid"],
        to: json["to"],
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "to": to,
        "from": from,
      };

  @override
  List<Object?> get props => [
        userid,
        to,
        from,
      ];

  static const tParams =
      GetChartParams(userid: "testId", to: "2023-05-14T01:18:56.606Z",from: "2023-05-14T01:18:56.606Z");
}
