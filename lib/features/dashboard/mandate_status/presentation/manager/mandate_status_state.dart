part of 'mandate_status_cubit.dart';

abstract class MandateStatusState {}

class GetMandateStatusLoaded extends Equatable with MandateStatusState{
  final List<GetMandateStatusEntity> getMandateStatusEntities;
  

  GetMandateStatusLoaded({
    required this.getMandateStatusEntities,
    
  });

  @override
  List<Object?> get props => [
    getMandateStatusEntities,
    
  ];
}

    