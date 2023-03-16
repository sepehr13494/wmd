part of 'blurred_privacy_cubit.dart';

abstract class BlurredPrivacyState {}

class GetIsBlurredLoaded extends Equatable with BlurredPrivacyState{
  
  final GetIsBlurredEntity getIsBlurredEntity;

  GetIsBlurredLoaded({
    
    required this.getIsBlurredEntity,
  });

  @override
  List<Object?> get props => [
    
    getIsBlurredEntity,
  ];
}
class SetBlurredLoaded extends Equatable with BlurredPrivacyState{
  
  final SetBlurredEntity setBlurredEntity;

  SetBlurredLoaded({
    
    required this.setBlurredEntity,
  });

  @override
  List<Object?> get props => [
    
    setBlurredEntity,
  ];
}

    