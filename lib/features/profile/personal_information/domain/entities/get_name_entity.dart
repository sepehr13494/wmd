import 'package:equatable/equatable.dart';

class GetNameEntity extends Equatable {
  const GetNameEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
      };

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
      ];
}
