import '../../domain/entities/get_name_entity.dart';

class GetNameResponse extends GetNameEntity {
  const GetNameResponse({
    required String firstName,
    required String lastName,
  }) : super(
          firstName: firstName,
          lastName: lastName,
        );

  factory GetNameResponse.fromJson(Map<String, dynamic> json) =>
      GetNameResponse(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
      );
}
