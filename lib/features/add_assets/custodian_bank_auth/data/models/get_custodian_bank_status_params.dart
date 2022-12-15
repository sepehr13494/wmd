import 'package:equatable/equatable.dart';

class GetCustodianBankStatusParams extends Equatable {
  final String id;
  const GetCustodianBankStatusParams({required this.id});

  factory GetCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankStatusParams(id: json['id']);

  Map<String, dynamic> toJson() => {'id': id};

  @override
  List<Object?> get props => [id];
}
