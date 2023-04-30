import 'package:equatable/equatable.dart';

class IsSafeDeviceEntity extends Equatable {
  final bool isSafe;
  final bool isIOS;
  final bool isAndroid;
  const IsSafeDeviceEntity(this.isSafe,
      {this.isIOS = false, this.isAndroid = false});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];
}
