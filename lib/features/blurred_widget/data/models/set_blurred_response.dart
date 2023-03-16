import 'package:wmd/features/blurred_widget/domain/entities/get_is_blurred_entity.dart';

class SetBlurredResponse extends IsBlurredEntity {
  const SetBlurredResponse();

  factory SetBlurredResponse.fromJson(Map<String, dynamic> json) =>
      SetBlurredResponse();

  static final tResponse = SetBlurredResponse();
}
