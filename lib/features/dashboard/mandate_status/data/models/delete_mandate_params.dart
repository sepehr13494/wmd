import 'package:equatable/equatable.dart';

class DeleteMandateParams extends Equatable {
  final int mandateId;
  const DeleteMandateParams(this.mandateId);

  factory DeleteMandateParams.fromJson(Map<String, dynamic> json) =>
      DeleteMandateParams(json['mandateId']);

  List<dynamic> toJson() => [mandateId];

  @override
  List<Object?> get props => [mandateId];

  static const tParams = DeleteMandateParams(1234);
}
