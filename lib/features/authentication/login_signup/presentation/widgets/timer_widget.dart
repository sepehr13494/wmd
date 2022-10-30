import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class TimerWidget extends StatefulWidget {
  final Function sendCodeAgain;
  const TimerWidget({Key? key, required this.sendCodeAgain}) : super(key: key);

  @override
  AppState<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends AppState<TimerWidget> {

  Timer? timer;
  final interval = const Duration(seconds: 1);
  bool canSend = true;

  int timerMaxSeconds = 20;

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
    if(timer != null){
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme, AppLocalizations appLocalizations) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(appLocalizations.auth_verify_text_noEmailReceived),
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
              : GestureDetector(
              onTap: () {
                _initTimer();
                widget.sendCodeAgain();
              },
              child: Text(appLocalizations.auth_verify_link_resend, style: TextStyle(color: Theme.of(context).primaryColor))),
        ),
      ],
    );
  }
}
