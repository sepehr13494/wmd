import 'package:wmd/features/profile/personal_information/domain/entities/phone_number_entity.dart';

import '../../domain/entities/get_name_entity.dart';

class GetNameResponse extends GetNameEntity {
  const GetNameResponse({
    required String email,
    required PhoneNumberEntity? phoneNumber,
    required String firstName,
    required String lastName,
  }) : super(
          email: email,
          phoneNumber: phoneNumber,
          firstName: firstName,
          lastName: lastName,
        );

  factory GetNameResponse.fromJson(Map<String, dynamic> json) =>
      GetNameResponse(
        email: json["email"] ?? "",
        phoneNumber: json["phoneNumber"] != null
            ? PhoneNumberEntity.fromJson(json["phoneNumber"])
            : const PhoneNumberEntity(countryCode: "", number: ""),
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
      );
}
