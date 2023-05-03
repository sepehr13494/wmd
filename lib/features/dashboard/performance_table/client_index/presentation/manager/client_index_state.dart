part of 'client_index_cubit.dart';

abstract class ClientIndexState {}

class GetClientIndexLoaded extends Equatable with ClientIndexState{
  
  final GetClientIndexEntity getClientIndexEntity;

  GetClientIndexLoaded({
    
    required this.getClientIndexEntity,
  });

  @override
  List<Object?> get props => [
    
    getClientIndexEntity,
  ];
}

    