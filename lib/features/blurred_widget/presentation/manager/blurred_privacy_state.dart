part of 'blurred_privacy_cubit.dart';

abstract class BlurredPrivacyState {}

class IsBlurredLoaded extends Equatable with BlurredPrivacyState {
  final bool isBlurred;

  IsBlurredLoaded({
    required this.isBlurred,
  });

  @override
  List<Object?> get props => [
        isBlurred,
      ];
}
