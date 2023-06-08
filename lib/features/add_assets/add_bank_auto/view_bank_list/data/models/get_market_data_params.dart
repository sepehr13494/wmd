import 'package:equatable/equatable.dart';

class GetMarketDataParams extends Equatable {
  final String identifier;
  final String? resultCount;
  const GetMarketDataParams({required this.identifier, this.resultCount});

  factory GetMarketDataParams.fromJson(Map<String, dynamic> json) =>
      GetMarketDataParams(
        identifier: json['identifier'],
        resultCount: json['resultCount'],
      );

  Map<String, dynamic> toJson() =>
      {"identifier": identifier, "resultCount": resultCount};

  @override
  // TODO: implement props
  List<Object?> get props => [identifier, resultCount];

  // static final tParams = GetMarketDataParams(id: "2323");
}
