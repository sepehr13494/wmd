import 'package:equatable/equatable.dart';

class GetSettingsParams extends Equatable {
  const GetSettingsParams();

  factory GetSettingsParams.fromJson(Map<String, dynamic> json) =>
      const GetSettingsParams();

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];

  static const tParams = GetSettingsParams();
}
