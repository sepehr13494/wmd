import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class ResendTimerWidget extends StatefulWidget {
  final int timerTime;
  final bool resetTime;
  final Function resetCallback;
  final Function handleOtpExpired;
  const ResendTimerWidget({
    Key? key,
    this.timerTime = 20,
    required this.handleOtpExpired,
    required this.resetTime,
    required this.resetCallback,
  }) : super(key: key);

  @override
  AppState<ResendTimerWidget> createState() => _ResendTimerWidgetState();
}

class _ResendTimerWidgetState extends AppState<ResendTimerWidget> {
  Timer? timer;
  final interval = const Duration(seconds: 1);
  bool canSend = true;

  int timerMaxSeconds = 60;

  int currentSeconds = 0;

  String newVerifyToken = "";

  String get timerText =>
      ((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0');

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
  void didUpdateWidget(covariant ResendTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    debugPrint("didChangeDependencies");
    debugPrint(widget.resetTime.toString());

    if (widget.resetTime) {
      _initTimer();
      widget.resetCallback();
    }
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
              text: appLocalizations.profile_otpVerification_button_resendSMSIn
                  .replaceAll("{{second}}", "")
                  .replaceAll(" s", " "),
              style: textTheme.bodyMedium!.apply(
                  decoration: TextDecoration.underline,
                  color: Colors.grey[800]),
            ),
            TextSpan(
              text: timerText,
              style: textTheme.bodyMedium!.apply(
                  decoration: TextDecoration.underline,
                  color: Colors.grey[800]),
            ),
          ])),
        if (canSend)
          RichText(
              text: TextSpan(style: const TextStyle(height: 1.3), children: [
            TextSpan(
              text: appLocalizations.profile_otpVerification_button_resendSMS,
              style: textTheme.bodyMedium!.toLinkStyle(context),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  widget.handleOtpExpired();
                },
            ),
          ])),
      ],
    );
  }
}
