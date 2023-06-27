part of 'tfo_login_cubit.dart';

abstract class TfoLoginState {}

class InitialState extends TfoLoginState {}
class TfoMandatesLoaded extends TfoLoginState {
   final List<Mandate> mandates;

  TfoMandatesLoaded(this.mandates);
}
