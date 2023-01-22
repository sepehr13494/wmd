part of 'listed_security_cubit.dart';

abstract class ListedSecurityState {}

class ListedSecurityInitial extends ListedSecurityState {}

class ListedSecuritySuccess extends ListedSecurityState {
  final List<ListedSecurityName> assets;

  ListedSecuritySuccess(this.assets);
}
