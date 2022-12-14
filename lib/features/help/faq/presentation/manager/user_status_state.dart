part of 'user_status_cubit.dart';

abstract class UserStatusState {}

class UserStatusLoaded extends Equatable with UserStatusState {
  final UserStatus userStatus;

  UserStatusLoaded({required this.userStatus});

  @override
  List<Object?> get props => [userStatus];
}
