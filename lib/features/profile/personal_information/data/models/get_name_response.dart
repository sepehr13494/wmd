import '../../domain/entities/get_name_entity.dart';

class GetNameResponse extends GetNameEntity {
  const GetNameResponse({
    required String email,
    required String phoneNumber,
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
        phoneNumber: json["phoneNumber"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
      );
}
