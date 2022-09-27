import 'package:flutter/material.dart';
import '../../../../core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';

class WelcomePage extends AppStatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return SafeArea(
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 50,
                              color: Colors.white,
                            )),
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
                                  text: "${appLocalizations.build_portfolio} ",
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
                          onPressed: () {},
                          child: Text(appLocalizations.join_with_email)),
                      const ContinueAppleButton(),
                      const SizedBox(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Divider(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                          ["google", "assets/images/linkedin.png", () {}],
                          ["twitter", "assets/images/twitter.png", () {}],
                          ["linkedin", "assets/images/linkedin.png", () {}],
                        ];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(socials.length, (index) {
                            return Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.all(12),
                              child: Image.asset(socials[index][1]),
                            );
                          }),
                        );
                      }),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(appLocalizations.already_have_account),
                          const SizedBox(width: 8),
                          Text(
                            appLocalizations.login,
                            style: textTheme.bodyText1!.toLinkStyle(context),
                          )
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
    );
  }
}

class ContinueAppleButton extends StatelessWidget {
  const ContinueAppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.apple),
            const SizedBox(width: 12),
            Text(AppLocalizations.of(context).continue_apple),
          ],
        ));
  }
}
