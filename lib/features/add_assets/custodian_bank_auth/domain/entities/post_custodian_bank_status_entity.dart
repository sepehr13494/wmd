import 'package:equatable/equatable.dart';

class PostCustodianBankStatusEntity extends Equatable {
  final bool success;
  const PostCustodianBankStatusEntity(this.success);

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [success];

  static const tResponse = true;
}
