part of 'base_cubit.dart';

@immutable
abstract class BaseState extends SplashState{}

class SuccessState extends BaseState{
  final AppSuccess appSuccess;

  SuccessState({required this.appSuccess});
}

class LoadingState extends BaseState{
  final String message;

  LoadingState({this.message = "loading..."});
}

class ErrorState extends BaseState{
  final Failure failure;
  final Function? tryAgainFunction;

  ErrorState({required this.failure,this.tryAgainFunction});
}