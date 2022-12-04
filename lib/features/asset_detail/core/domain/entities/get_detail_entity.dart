import 'package:equatable/equatable.dart';

abstract class GetDetailEntity extends Equatable {
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props;
}
