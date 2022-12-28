import 'package:equatable/equatable.dart';

class GetNameEntity extends Equatable {
  const GetNameEntity({
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toJson() => {
        "email": email,
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
      };

  @override
  List<Object?> get props => [
        email,
        phoneNumber,
        firstName,
        lastName,
      ];
}
