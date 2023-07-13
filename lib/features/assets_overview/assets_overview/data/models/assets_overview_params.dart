import 'package:equatable/equatable.dart';

class AssetsOverviewParams extends Equatable{

  final String? type;

  const AssetsOverviewParams({this.type});

  static const tParams = AssetsOverviewParams(type: "TestType");

  factory AssetsOverviewParams.fromJson(Map<String, dynamic> json) => AssetsOverviewParams(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type":type,
  };

  @override
  List<Object?> get props => [type];
}