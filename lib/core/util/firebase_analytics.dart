class AnalyticsUtils {
  static const String signUpAction = "Sign up CTA";
  static const String loginAction = "Login CTA";
  static const String guidedOnboardingAction = "Add an Asset page reached";
  static const String assetAdditionAction = "Add CTA";
  static const String assetExposureWidgetMoreAction = "More CTA";
  static const String geographyWidgetMoreAction = "More CTA";
  static const String assetExposureArrowAction = "More CTA";
  static const String changePasswordAction = "Profile CTA";

  static const SignUpStartEvent = {
    "label": "Sign up CTA",
    "category": "Start sign-up",
    "action": signUpAction,
  };

  static const LoginStartedEvent = {
    "label": "Login CTA",
    "category": "Start login",
    "action": loginAction,
  };
}
