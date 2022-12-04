import 'package:equatable/equatable.dart';

class RadioButtonOptions<T> extends Equatable {
  final String label;
  final T value;

  const RadioButtonOptions({required this.label, required this.value});

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };

  factory RadioButtonOptions.fromJson(Map<String, dynamic> json) =>
      RadioButtonOptions(
        value: json["value"],
        label: json["label"],
      );

  @override
  List<Object?> get props => [label, value];
}
