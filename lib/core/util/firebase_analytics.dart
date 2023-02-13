import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsUtils {
  static const String signUpAction = "Signup_CTA";
  static const String loginAction = "Login_CTA";
  static const String guidedOnboardingAction = "Add_an_Asset_page_reached";
  static const String assetAdditionAction = "Add_CTA";
  static const String forgotPasswordAction = "Forget_password_CTA";
  static const String assetExposureWidgetMoreAction = "More_CTA";
  static const String geographyWidgetMoreAction = "More_CTA";
  static const String assetExposureArrowAction = "More_CTA";
  static const String changePasswordAction = "Profile_CTA";
  static const String helpSupportAction = "Help_CTA";
  static const String changeDashboardFilterAction = "Dashboard_Filter_CTA";

// dynamic
  static String linkBankAction(bankName) => "${bankName}_Connect_CTA";

  static linkBankEvent(bankName) => {
        "action": guidedOnboardingAction,
        "category": "Complete the guided on-boarding",
        "label": "$bankName Connect CTA"
      };

  static changeDashboardFilterEvent(filter) => {
        "action": changeDashboardFilterAction,
        "category": "Change the date (personalization) on dashboard",
        "label": "$filter days chosen to be viewed"
      };

  static const scheduleCallEvent = {
    "label": "Entered help page from top navigation",
    "category": "Start scheduling a call",
    "action": helpSupportAction,
  };

  static const contactBusinessTeamEvent = {
    "label": "Entered help page from top navigation",
    "category": "Start leaving a message",
    "action": helpSupportAction,
  };

  static const forgotPasswordEvent = {
    "label": "Forget password CTA",
    "category": "Choose forget password",
    "action": forgotPasswordAction,
  };

  static const resetPasswordEvent = {
    "label": "Reset password CTA",
    "category": "Choose new password",
    "action": forgotPasswordAction,
  };

  static const signUpStartEvent = {
    "label": "Sign up CTA",
    "category": "Start sign-up",
    "action": signUpAction,
  };

  static const loginStartedEvent = {
    "label": "Login CTA",
    "category": "Start login",
    "action": loginAction,
  };

  static const guidedOnboardingEvent = {
    "action": guidedOnboardingAction,
    "category": "Complete the guided on-boarding",
    "label": "Add an Asset page reached"
  };

  static const addAssetEvent = {
    "action": assetAdditionAction,
    "category": "Add an asset from dashboard",
    "label": "Add CTA"
  };

  static const assetClassMoreRedirectionEvent = {
    "action": assetExposureWidgetMoreAction,
    "category":
        "Moving to Asset Overview page from Asset Class Exposure widget (more)",
    "label": "More CTA"
  };

  static const geographyMoreRedirectionEvent = {
    "action": geographyWidgetMoreAction,
    "category":
        "Moving to Asset Overview page from Geography Exposure widget (more)",
    "label": "More CTA"
  };

  static const assetOverviewInsideMoreEvent = {
    "action": assetExposureArrowAction,
    "category":
        "Moving to Asset Overview page from Asset Class Exposure widget (arrow)",
    "label": "More CTA"
  };

  static const geographyOverviewInsideMoreEvent = {
    "action": assetExposureArrowAction,
    "category":
        "Moving to Asset Overview page from Geography Exposure widget (arrow)",
    "label": "More CTA"
  };

  static const addAssetOverviewEvent = {
    "action": "Add CTA",
    "category": "Add an asset from asset overview page",
    "label": "Add CTA",
  };

  static const changePasswordEvent = {
    "action": changePasswordAction,
    "category": "Go to profile",
    "label": "Profile CTA"
  };

  static const googleLoginEvent = {
    "category": "Login using google",
    "action": "Google login option in the login page ",
    "label": "Google login option in the login page ",
  };

  static const twitterLoginEvent = {
    "category": "Login using Twitter",
    "action": "Twitter login option in the login page ",
    "label": "Twitter login option in the login page ",
  };

  static const linkedInLoginEvent = {
    "category": "Login using LinkedIn",
    "action": "LinkedIn login option in the login page ",
    'label': "LinkedIn login option in the login page ",
  };

  static const googleSignupEvent = {
    "category": "Social sign up using google",
    "action": "Google sign up option in the sign up page",
    "label": "Google Signup option in the Signup page",
  };

  static const twitterSignupEvent = {
    "category": "Social sign up using Twitter",
    "action": "Twitter sign up option in the sign up page",
    "label": "Twitter Signup option in the Signup page",
  };

  static const linkedInSignupEvent = {
    "category": "Social sign up using LinkedIn",
    "action": "LinkedIn sign up option in the sign up page",
    "label": "LinkedIn Signup option in the Signup page",
  };

  static triggerEvent({action, params}) async {
    try {
      await FirebaseAnalytics.instance
          .logEvent(name: action, parameters: params);
    } catch (e) {
      debugPrint("logging failed firebase--");
      debugPrint(e.toString());
    }
  }
}
