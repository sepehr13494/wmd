import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../error_and_success/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];

  Map<String, dynamic>? toJson() => null;
}

class OwnerIdParams extends Equatable {

  final String ownerId;

  const OwnerIdParams({required this.ownerId});

  @override
  List<Object?> get props => [];

  Map<String, dynamic>? toJson() =>
      {
        "ownerId": ownerId
      };
}

