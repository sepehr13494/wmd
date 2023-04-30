part of 'safe_device_cubit.dart';

abstract class SafeDeviceState {}

class IsSafeDeviceLoaded extends Equatable with SafeDeviceState{
  
  final IsSafeDeviceEntity isSafeDeviceEntity;

  IsSafeDeviceLoaded({
    
    required this.isSafeDeviceEntity,
  });

  @override
  List<Object?> get props => [
    
    isSafeDeviceEntity,
  ];
}

    