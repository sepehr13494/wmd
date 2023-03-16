part of 'blurred_privacy_cubit.dart';

abstract class BlurredPrivacyState {}

class IsBlurredLoaded extends Equatable with BlurredPrivacyState {
  final IsBlurredEntity isBlurredEntity;

  IsBlurredLoaded({
    required this.isBlurredEntity,
  });

  @override
  List<Object?> get props => [
        isBlurredEntity,
      ];
}
