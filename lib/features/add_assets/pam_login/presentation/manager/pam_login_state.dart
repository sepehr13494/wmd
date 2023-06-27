part of 'pam_login_cubit.dart';

abstract class PamLoginState {}

class InitialState extends PamLoginState {}

class MandatesLoaded extends PamLoginState {
   final List<Mandate> mandates;

  MandatesLoaded(this.mandates);
}
