part of 'linked_accounts_cubit.dart';

abstract class LinkedAccountsState {}

class GetLinkedAccountsLoaded extends Equatable with LinkedAccountsState{
  final List<GetLinkedAccountsEntity> getLinkedAccountsEntities;
  

  GetLinkedAccountsLoaded({
    required this.getLinkedAccountsEntities,
    
  });

  @override
  List<Object?> get props => [
    getLinkedAccountsEntities,
    
  ];
}

    