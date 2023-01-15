import 'package:equatable/equatable.dart';

@Deprecated('Replaced with asset summary')
abstract class GetDetailEntity extends Equatable {
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props;
}
