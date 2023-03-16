import '../../domain/entities/get_is_blurred_entity.dart';

class GetIsBlurredResponse extends IsBlurredEntity {
  GetIsBlurredResponse();

  factory GetIsBlurredResponse.fromJson(Map<String, dynamic> json) =>
      GetIsBlurredResponse();

  static final tResponse = GetIsBlurredResponse();
}
