part of 'listed_security_cubit.dart';

abstract class ListedSecurityState {}

class ListedSecurityInitial extends ListedSecurityState {}

class ListedSecuritySaved extends Equatable with ListedSecurityState {
  final AddAsset listedSecuritySaveResponse;

  ListedSecuritySaved({required this.listedSecuritySaveResponse});
  @override
  List<Object?> get props => [listedSecuritySaveResponse];
}
