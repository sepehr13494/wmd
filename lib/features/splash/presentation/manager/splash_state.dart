part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoaded extends SplashState{
  final bool isLogin;

  SplashLoaded({required this.isLogin});
}
