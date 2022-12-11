import 'package:equatable/equatable.dart';

class GetNameEntity extends Equatable {
  const GetNameEntity({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
      };

  @override
  List<Object?> get props => [
        firstName,
        lastName,
      ];
}
