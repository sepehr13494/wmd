import 'package:equatable/equatable.dart';

class TimeFilterObj extends Equatable {
  final String key;
  final dynamic value;

  const TimeFilterObj({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [value];

  static const tTimeFilterObj = TimeFilterObj(key: "Last7Days", value: "Last7Days");
}
