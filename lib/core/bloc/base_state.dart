part of 'base_cubit.dart';

@immutable
abstract class BaseState {}

class SuccessState extends BaseState{
  final AppSuccess appSuccess;

  SuccessState({required this.appSuccess});
}

class LoadingState extends BaseState{}

class ErrorState extends BaseState{
  final Failure failure;

  ErrorState({required this.failure});
}