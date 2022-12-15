import 'package:equatable/equatable.dart';

class OwnerIdParams extends Equatable {

  final String ownerId;

  const OwnerIdParams({required this.ownerId});

  @override
  List<Object?> get props => [ownerId];

  Map<String, dynamic>? toJson() =>
      {
        "ownerId": ownerId
      };
}