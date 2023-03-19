import 'package:wmd/features/blurred_widget/domain/entities/is_blurred_entity.dart';

class SetBlurredResponse extends IsBlurredEntity {
  const SetBlurredResponse({required super.isBlurred});

  factory SetBlurredResponse.fromJson(Map<String, dynamic> json) =>
      SetBlurredResponse(isBlurred: json['isBlurred']);

  static const tResponse = SetBlurredResponse(isBlurred: true);
}
