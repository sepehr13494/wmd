import 'package:equatable/equatable.dart';

class GetChartParams extends Equatable {
  const GetChartParams({
    required this.userid,
    required this.to,
  });

  final String userid;
  final String to;

  factory GetChartParams.fromJson(Map<String, dynamic> json) => GetChartParams(
        userid: json["userid"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "to": to,
      };

  @override
  List<Object?> get props => [
        userid,
        to,
      ];

  static const tParams = GetChartParams(userid: "testId", to: "2023-05-14T01:18:56.606Z");
}
