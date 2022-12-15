import 'package:equatable/equatable.dart';

class GetAllValuationParams extends Equatable {
  final String id;
  const GetAllValuationParams(this.id);

  factory GetAllValuationParams.fromJson(Map<String, dynamic> json) =>
      GetAllValuationParams(json['id']);

  Map<String, dynamic> toJson() => {'id': id};

  @override
  List<Object?> get props => [id];

  static const tParams = GetAllValuationParams('id');
}
