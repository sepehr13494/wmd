import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:twitter_login/twitter_login.dart';

class SocialAuthBar extends StatelessWidget {
  const SocialAuthBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      List socials = [
        [
          "google",
          "assets/images/google.svg",
          () async {
            _googleLogin();
          }
        ],
        [
          "twitter",
          "assets/images/twitter.svg",
          () {
            _twitterLogin();
          }
        ],
        [
          "linkedin",
          "assets/images/linkedin.svg",
          () {
            _linkedInLogin(context);
          }
        ],
      ];
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(socials.length, (index) {
          return InkWell(
            onTap: () {
              socials[index][2]();
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                socials[index][1],
                height: 30,
              ),
            ),
          );
        }),
      );
    });
  }

  static void _linkedInLogin(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => SafeArea(
                  child: Scaffold(
                    body: LinkedInUserWidget(
                      redirectUrl: "redirectUrl",
                      clientId: "clientId",
                      clientSecret: "clientSecret",
                      onGetUserProfile: (UserSucceededAction linkedInUser) {
                        debugPrint(
                            'Access token ${linkedInUser.user.token.accessToken}');
                        debugPrint(
                            'First name: ${linkedInUser.user.firstName?.localized?.label}');
                        debugPrint(
                            'Last name: ${linkedInUser.user.lastName?.localized?.label}');
                      },
                      onError: (UserFailedAction e) {
                        debugPrint('Error: ${e.toString()}');
                      },
                    ),
                  ),
                ))));
  }

  static Future<void> _googleLogin() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: "xxxِ",
        scopes: [
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );
      final result = await googleSignIn.signIn();
      debugPrint(result.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future<void> _twitterLogin() async {
    final twitterLogin = TwitterLogin(
      // Consumer API keys
      apiKey: 'xxxx',
      // Consumer API Secret keys
      apiSecretKey: 'xxxx',
      // Registered Callback URLs in TwitterApp
      // Android is a deeplink
      // iOS is a URLScheme
      redirectURI: 'app://wmd.com/twitter',
    );
    final authResult = await twitterLogin.login();
    switch (authResult.status!) {
      case TwitterLoginStatus.loggedIn:
        // success
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        break;
      case TwitterLoginStatus.error:
        // error
        break;
    }
  }
}
