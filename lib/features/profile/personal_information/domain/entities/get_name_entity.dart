import 'package:country_picker/country_picker.dart';
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

  Map<String, dynamic> toJson() {
    var country;
    if (phoneNumber?.countryCode != null) {
      var allCountries = CountryService().getAll();
      for (var element in allCountries) {
        if (element.phoneCode == phoneNumber?.countryCode.replaceAll("+", "")) {
          country = element;
        }
      }
    }
    print(country);
    return {
      "email": email,
      "phoneNumber": phoneNumber?.number,
      "country": country,
      "firstName": firstName,
      "lastName": lastName,
    };
  }

  @override
  List<Object?> get props => [
        email,
        phoneNumber,
        firstName,
        lastName,
      ];
}
