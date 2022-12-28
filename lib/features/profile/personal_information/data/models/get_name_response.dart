import '../../domain/entities/get_name_entity.dart';

class GetNameResponse extends GetNameEntity {
  const GetNameResponse({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
        );

  factory GetNameResponse.fromJson(Map<String, dynamic> json) =>
      GetNameResponse(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
      );
}
