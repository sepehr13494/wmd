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
  static const String assetExposureArrowAction = "Arrow_CTA";
  static const String changePasswordAction = "Profile_CTA";
  static const String helpSupportAction = "Help_CTA";
  static const String changeDashboardFilterAction = "Dashboard_Filter_CTA";

// dynamic
  static String viewIndividualAssetAction(asset) => "View_$asset";
  static String changeDateIndividualAssetAction(asset, date) =>
      "${date}_chosen_to_be_viewed_for_$asset";
  static String linkBankAction(bankName) => "${bankName}_Connect_CTA";
  static String linkBankStep2Action(bankName) => "${bankName}_Form_viewed";
  static String linkBankStep3Action(bankName) =>
      "${bankName}_Form_shared_with_the_bank";

  static linkBankEvent(bankName) => {
        "action": "$bankName Connect CTA",
        "category": "Link custodian bank account (aggregation)",
        "label": "$bankName Connect CTA"
      };

  static linkBankStep2Event(bankName) => {
        "action": "$bankName  Form viewed",
        "category": "Link custodian bank account (Step 1) (aggregation)",
        "label": "$bankName Form viewed"
      };

  static linkBankStep3Event(bankName) => {
        "action": "$bankName Form shared with the bank",
        "category": "Share the letter with bank (Step 2) (aggregation)",
        "label": "$bankName Form shared with the bank"
      };

  static changeDashboardFilterEvent(filter) => {
        "action": changeDashboardFilterAction,
        "category": "Change the date (personalization) on dashboard",
        "label": "$filter days chosen to be viewed"
      };

  static viewIndividualAssetEvent(asset) => {
        "action": "View $asset",
        "category": "Moving to Individual Asset page",
        "label": "View $asset"
      };

  static changeDateIndividualAssetEvent(asset, date) => {
        "action": "$date chosen to be viewed for $asset",
        "category":
            "Change the date (personalization) on individual asset page",
        "label": "$date chosen to be viewed for $asset"
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

  static const addAssetOverviewEvent = {
    "action": assetAdditionAction,
    "category": "Add an asset from asset overview page",
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
    "label": "Arrow CTA"
  };

  static const geographyOverviewInsideMoreEvent = {
    "action": assetExposureArrowAction,
    "category":
        "Moving to Asset Overview page from Geography Exposure widget (arrow)",
    "label": "Arrow CTA"
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
