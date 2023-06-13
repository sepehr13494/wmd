import 'package:equatable/equatable.dart';

class DeleteMandateParams extends Equatable {
  final int mandateId;
  const DeleteMandateParams(this.mandateId);

  factory DeleteMandateParams.fromJson(Map<String, dynamic> json) =>
      DeleteMandateParams(json['mandateId']);

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [mandateId];

  static const tParams = DeleteMandateParams(1234);
}
