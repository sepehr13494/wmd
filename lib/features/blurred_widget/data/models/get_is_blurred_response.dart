import '../../domain/entities/is_blurred_entity.dart';

class GetIsBlurredResponse extends IsBlurredEntity {
  const GetIsBlurredResponse({required super.isBlurred});

  factory GetIsBlurredResponse.fromJson(Map<String, dynamic> json) =>
      GetIsBlurredResponse(isBlurred: json["isBlurred"]);

  static const tResponse = GetIsBlurredResponse(isBlurred: false);
}
