part of 'custodian_status_list_cubit.dart';

abstract class CustodianStatusListState {}

class StatusListLoaded extends Equatable with CustodianStatusListState {
  final List<StatusEntity> statusEntity;

  StatusListLoaded({
    required this.statusEntity,
  });

  @override
  List<Object> get props => [
        statusEntity,
      ];
}
