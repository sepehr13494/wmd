import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class BasicTimerWidget extends StatefulWidget {
  final int timerTime;
  final bool isForgotPasswordPage;
  const BasicTimerWidget(
      {Key? key, this.timerTime = 20, this.isForgotPasswordPage = false})
      : super(key: key);

  @override
  AppState<BasicTimerWidget> createState() => _BasicTimerWidgetState();
}

class _BasicTimerWidgetState extends AppState<BasicTimerWidget> {
  Timer? timer;
  final interval = const Duration(seconds: 1);
  bool canSend = true;

  int timerMaxSeconds = 200;

  int currentSeconds = 0;

  String newVerifyToken = "";

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    _initTimer();
    super.initState();
  }

  void _initTimer() {
    setState(() {
      canSend = false;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentSeconds += 1;
      });
      if (currentSeconds >= timerMaxSeconds) {
        timer.cancel();
        setState(() {
          currentSeconds = 0;
          canSend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!canSend)
          RichText(
              text: TextSpan(style: const TextStyle(height: 1.3), children: [
            TextSpan(
              text: "Your code will expire in:",
              style: textTheme.bodyMedium,
            ),
          ])),
        if (!canSend)
          const SizedBox(
            width: 8,
          ),
        Flexible(
            child: !canSend
                ? Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      timerText,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
                : Text(
                    "Your verification code has expired. Click on 'Resend code' to receive a new one.",
                    style: TextStyle(color: Colors.red[800]),
                    textAlign: TextAlign.center,
                  )),
      ],
    );
  }
}
