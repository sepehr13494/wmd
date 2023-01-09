import 'package:equatable/equatable.dart';

class TimeFilterObj extends Equatable {
  final String key;
  final int value;

  const TimeFilterObj({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}
