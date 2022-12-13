import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class StatusStepWidget extends AppStatelessWidget {
  final String stepNumber;
  final String title;
  final bool isDone;
  final String? subtitle;
  final String? doneSubtitle;
  final String trailing;
  final void Function()? onDone;
  final void Function()? onDoneAgain;
  const StatusStepWidget({
    required this.title,
    required this.stepNumber,
    required this.trailing,
    this.isDone = false,
    this.doneSubtitle,
    this.subtitle,
    this.onDone,
    this.onDoneAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return ListTile(
      leading: isDone
          ? const Icon(Icons.check_circle_outline_rounded)
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              height: 18,
              width: 18,
              child: Center(
                  child: Text(
                stepNumber,
                style: textTheme.bodySmall!
                    .apply(color: Theme.of(context).backgroundColor),
                textAlign: TextAlign.center,
              )),
            ),
      title: Text(title),
      subtitle: Builder(
        builder: (context) {
          if (isDone) {
            if (doneSubtitle != null) {
              return InkWell(
                onTap: onDoneAgain,
                child: Text(
                  doneSubtitle!,
                  style: textTheme.bodySmall!.apply(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline),
                ),
              );
            }
          } else {
            if (subtitle != null) {
              return InkWell(
                onTap: onDone,
                child: Text(
                  subtitle!,
                  style: textTheme.bodySmall!.apply(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline),
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
      trailing: Text(trailing),
    );
  }
}
