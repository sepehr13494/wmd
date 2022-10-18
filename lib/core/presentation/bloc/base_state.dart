part of 'base_cubit.dart';

@immutable
abstract class BaseState extends Equatable
    with LoginSignUpState, SplashState, VideoControllerState , VerifyEmailState{}

class SuccessState extends BaseState {
  final AppSuccess appSuccess;

  SuccessState({required this.appSuccess});

  @override
  List<Object?> get props => [appSuccess];
}

class LoadingState extends BaseState {
  final String message;

  LoadingState({this.message = "loading..."});

  @override
  List<Object?> get props => [message];
}

class ErrorState extends BaseState {
  final Failure failure;
  final Function? tryAgainFunction;

  ErrorState({required this.failure, this.tryAgainFunction});

  @override
  List<Object?> get props => [failure, tryAgainFunction];
}
