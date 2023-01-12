import 'package:equatable/equatable.dart';
import 'package:wmd/features/profile/personal_information/domain/entities/phone_number_entity.dart';

class GetNameEntity extends Equatable {
  const GetNameEntity({
    required this.email,
    this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  final String email;
  final PhoneNumberEntity? phoneNumber;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toJson() => {
        "email": email,
        "phoneNumber": phoneNumber?.number,
        //"country": phoneNumber?.countryCode,
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
