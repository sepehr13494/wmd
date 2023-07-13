part of 'force_update_cubit.dart';

abstract class ForceUpdateState {}

class GetForceUpdateLoaded extends Equatable with ForceUpdateState{
  
  final GetForceUpdateEntity getForceUpdateEntity;

  GetForceUpdateLoaded({
    
    required this.getForceUpdateEntity,
  });

  @override
  List<Object?> get props => [
    getForceUpdateEntity,
  ];
}

    