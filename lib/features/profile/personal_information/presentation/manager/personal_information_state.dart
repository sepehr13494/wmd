part of 'personal_information_cubit.dart';

abstract class PersonalInformationState {}

class PersonalInformationLoaded extends Equatable
    with PersonalInformationState {
  final GetNameEntity getNameEntity;

  PersonalInformationLoaded({
    required this.getNameEntity,
  });

  @override
  List<Object> get props => [
        getNameEntity,
      ];
}

class SuccessStatePhone extends BaseState {
  final AppSuccess appSuccess;

  SuccessStatePhone({required this.appSuccess});

  @override
  List<Object?> get props => [appSuccess];
}

class SuccessStateName extends BaseState {
  final AppSuccess appSuccess;

  SuccessStateName({required this.appSuccess});

  @override
  List<Object?> get props => [appSuccess];
}
