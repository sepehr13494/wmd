import 'package:wmd/core/domain/usecases/usercase.dart';

class SetBlurredParams extends NoParams {
  final bool isBlurred;

  static final tParams = SetBlurredParams(isBlurred: true);

  SetBlurredParams({required this.isBlurred});
}
