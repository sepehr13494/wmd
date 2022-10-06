import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:video_player/video_player.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/overlay.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/colors.dart';
import '../../../../core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  AppState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends AppState<WelcomePage> {
  // const WelcomePage({Key? key}) : super(key: key);

  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // initializePlayer();
  }

  Future<VideoPlayerController> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(BlocProvider.of<
                    LocalizationManager>(context)
                .state
                .languageCode ==
            "ar"
        ? "https://a.storyblok.com/f/127566/x/fad761400a/tfo_mvp_walk-through_arabic_no_logos_1108.mp4"
        : 'https://a.storyblok.com/f/127566/x/4770bdc9ca/tfo-mvp-walk-through-english-no-logo_1108.mp4');
    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _createChewieController();
    setState(() {});
    return _videoPlayerController;
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      // showControls: false,
      looping: false,
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const CustomAuthAppBar(backgroundColor: Colors.transparent),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
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
                        Expanded(
                          flex: 6,
                          child: IconButton(
                            onPressed: () async {
                              final videoController = await initializePlayer();
                              Navigator.of(context).push(
                                OverlayModal(
                                  videoPlayerController: videoController,
                                  chewieController: _chewieController,
                                  childComponent: Expanded(
                                    child: Center(
                                      child: _chewieController != null &&
                                              _chewieController!
                                                  .videoPlayerController
                                                  .value
                                                  .isInitialized
                                          ? Chewie(
                                              controller: _chewieController!,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                CircularProgressIndicator(),
                                                SizedBox(height: 20),
                                                Text('Loading'),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.4),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(height: 1.3),
                              children: [
                                TextSpan(
                                    text:
                                        "${appLocalizations.build_portfolio} ",
                                    style: textTheme.headlineSmall!
                                        .apply(fontWeightDelta: 4)),
                                TextSpan(
                                    text: appLocalizations.build_portfolio2,
                                    style: textTheme.headlineSmall),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.register);
                            },
                            child: Text(appLocalizations.join_with_email)),
                        const ContinueAppleButton(),
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
                                appLocalizations.or_sign_up,
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
                            Text(appLocalizations.already_have_account),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                                context.push(AppRoutes.login);
                              },
                              child: Text(
                                appLocalizations.login,
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
            ),
          ),
        ),
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
            Text(AppLocalizations.of(context).continue_apple),
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
