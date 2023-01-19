import 'package:equatable/equatable.dart';

class GetSeeMoreParams extends Equatable {
  final String type;
  final String id;
  const GetSeeMoreParams({
    required this.type,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        type: type,
      };

  @override
  List<Object?> get props => [type];

  static const tParams = GetSeeMoreParams(type: 'BankAccount', id: 'id');
}
