import 'package:equatable/equatable.dart';

class GetValuationParams extends Equatable {
  final String id;
  const GetValuationParams({required this.id});

  factory GetValuationParams.fromJson(Map<String, dynamic> json) =>
      GetValuationParams(id: json['id']);

  Map<String, dynamic> toJson() => {"transactionId": id};

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  static final tParams = GetValuationParams(id: "2323");
}
