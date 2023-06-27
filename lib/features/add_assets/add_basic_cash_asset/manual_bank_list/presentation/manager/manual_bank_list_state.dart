part of 'manual_bank_list_cubit.dart';

abstract class ManualBankListState {}

class GetManualListLoaded extends Equatable with ManualBankListState{
  final List<GetManualListEntity> getManualListEntities;
  

  GetManualListLoaded({
    required this.getManualListEntities,
    
  });

  @override
  List<Object?> get props => [
    getManualListEntities,
    
  ];
}

    