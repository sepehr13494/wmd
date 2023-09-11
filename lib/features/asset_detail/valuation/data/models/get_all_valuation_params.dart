import 'package:equatable/equatable.dart';

class GetAllValuationParams extends Equatable {
  final String id;
  final String? type;
  const GetAllValuationParams(this.id, this.type);

  factory GetAllValuationParams.fromJson(Map<String, dynamic> json) =>
      GetAllValuationParams(json['id'], json['type']);

  Map<String, dynamic> toJson() => {'id': id};

  @override
  List<Object?> get props => [id];

  static const tParams = GetAllValuationParams('id', 'type');
}
