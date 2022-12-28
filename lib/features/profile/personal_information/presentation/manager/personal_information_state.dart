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
