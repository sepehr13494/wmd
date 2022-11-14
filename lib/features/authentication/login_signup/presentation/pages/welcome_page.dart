import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/video_player_widget/video_player_widget.dart';

class WelcomePage extends AppStatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const CustomAuthAppBar(backgroundColor: Colors.transparent),
            body: WidthLimiterWidget(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) {
                        final Color bgColor =
                            Theme.of(context).scaffoldBackgroundColor;
                        return LinearGradient(
                            colors: [bgColor, Colors.transparent, bgColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.3, 1.0]).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Image.asset(
                        "assets/images/welcome_bg.png",
                        width: double.maxFinite,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 44),
                        const Expanded(
                          flex: 6,
                          child: WelcomeVideoPlayerWidget(),
                        ),
                        Container(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.4),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          // height: 100,
                          width: responsiveHelper.optimalDeviceWidth,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 100.0,
                              autoPlay: true,
                              viewportFraction: 1,
                            ),
                            items: [
                              "${appLocalizations.auth_signup_productDetails_one} ${appLocalizations.auth_signup_productDetails_and}",
                              appLocalizations.auth_signup_productDetails_two,
                              appLocalizations.auth_signup_productDetails_three
                            ].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      width:
                                          responsiveHelper.optimalDeviceWidth +
                                              20,
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: const TextStyle(height: 1.3),
                                          children: [
                                            TextSpan(
                                                text: i,
                                                style: textTheme.headlineSmall),
                                          ],
                                        ),
                                      ));
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.register);
                            },
                            child:
                                Text(appLocalizations.auth_signup_button_join)),
                        if (Platform.isIOS) const ContinueAppleButton(),
                        const SizedBox(),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Divider(),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Text(
                                appLocalizations.auth_signup_text_social,
                                style: textTheme.bodySmall!
                                    .apply(fontWeightDelta: -2),
                              ),
                            ),
                          ],
                        ),
                        Builder(builder: (context) {
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
                        }),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(appLocalizations
                                .auth_signup_text_alreadyHaveAnAccount),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(AppRoutes.login);
                              },
                              child: Text(
                                appLocalizations.auth_signup_link_login,
                                style:
                                    textTheme.bodyText1!.toLinkStyle(context),
                              ),
                            ),
                          ],
                        ),
                      ]
                          .map((e) => (e is Expanded || e is Spacer)
                              ? e
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: e,
                                ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _linkedInLogin(context) {
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
                        print(
                            'Access token ${linkedInUser.user.token.accessToken}');
                        print(
                            'First name: ${linkedInUser.user.firstName?.localized?.label}');
                        print(
                            'Last name: ${linkedInUser.user.lastName?.localized?.label}');
                      },
                      onError: (UserFailedAction e) {
                        print('Error: ${e.toString()}');
                      },
                    ),
                  ),
                ))));
  }

  Future<void> _googleLogin() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: "xxxِ",
        scopes: [
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );
      final result = await googleSignIn.signIn();
      print(result.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _twitterLogin() async {
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

class ContinueAppleButton extends StatelessWidget {
  const ContinueAppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          _signInWithApple();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.apple),
            const SizedBox(width: 12),
            Text(AppLocalizations.of(context).auth_signup_button_appleLogin),
          ],
        ));
  }

  Future<void> _signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential);
  }
}
