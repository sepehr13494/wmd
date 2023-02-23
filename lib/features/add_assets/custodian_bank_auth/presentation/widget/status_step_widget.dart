import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';

class StatusStepWidget extends StatefulWidget {
  final String stepNumber;
  final String title;
  final bool isDone;
  final bool showInput;
  final String? subtitle;
  final String? doneSubtitle;
  final String trailing;
  final void Function(String? val)? onDone;
  final void Function()? onDoneAgain;
  const StatusStepWidget({
    required this.title,
    required this.stepNumber,
    required this.trailing,
    this.isDone = false,
    this.showInput = false,
    this.doneSubtitle,
    this.subtitle,
    this.onDone,
    this.onDoneAgain,
    Key? key,
  }) : super(key: key);

  @override
  AppState<StatusStepWidget> createState() => _StatusStepWidgetState();
}

class _StatusStepWidgetState extends AppState<StatusStepWidget> {
  late final TextField input;
  var isButtonDisable = false;

  @override
  void initState() {
    super.initState();
    input = TextField(
      controller: TextEditingController()
        ..addListener(() {
          setState(() {});
        }),
    );
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    isButtonDisable = widget.showInput &&
        input.controller!.text.isEmpty &&
        widget.onDone != null;
    return ListTile(
      leading: widget.isDone
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
                widget.stepNumber,
                style: textTheme.bodySmall!
                    .apply(color: Theme.of(context).backgroundColor),
                textAlign: TextAlign.center,
              )),
            ),
      title: Text(widget.title, style: textTheme.bodyLarge),
      subtitle: Builder(
        builder: (context) {
          if (widget.isDone) {
            if (widget.doneSubtitle != null) {
              return InkWell(
                onTap: widget.onDoneAgain,
                child: Text(
                  widget.doneSubtitle!,
                  style: textTheme.bodySmall!.apply(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline),
                ),
              );
            }
          } else {
            if (widget.subtitle != null) {
              var isButtonDisable = widget.showInput &&
                  input.controller!.text.isEmpty &&
                  widget.onDone != null;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showInput) ...[
                    Row(
                      children: [
                        Text(
                          'Confirm CIF number',
                          style: textTheme.bodyMedium,
                        ),
                        const InfoIcon(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    input,
                    const SizedBox(height: 4),
                  ],
                  InkWell(
                    onTap:
                        isButtonDisable ? null : () => widget.onDone!('sadf'),
                    child: Text(
                      widget.subtitle!,
                      style: textTheme.bodySmall!.apply(
                          color: isButtonDisable
                              ? Theme.of(context).primaryColor.withOpacity(0.4)
                              : Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
      trailing: Text(widget.trailing),
    );
  }
}

class CifStatusWidget extends StatefulWidget {
  final String stepNumber;
  final String title;
  final String? accountId;
  final String? subtitle;
  final bool ready;
  final String trailing;
  final void Function(String? val)? onDone;
  final void Function()? onDoneAgain;
  const CifStatusWidget({
    required this.title,
    required this.stepNumber,
    required this.trailing,
    this.ready = true,
    this.accountId,
    this.subtitle,
    this.onDone,
    this.onDoneAgain,
    Key? key,
  }) : super(key: key);

  @override
  AppState<CifStatusWidget> createState() => _StatusSecondStatusWidget();
}

class _StatusSecondStatusWidget extends AppState<CifStatusWidget> {
  late final TextField input;
  var isButtonDisable = false;

  @override
  void initState() {
    super.initState();
    input = TextField(
      controller: TextEditingController(text: widget.accountId)
        ..addListener(() {
          setState(() {});
        }),
      enabled: widget.accountId == null,
    );
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    isButtonDisable = widget.accountId != null &&
        input.controller!.text.isEmpty &&
        widget.onDone != null;
    return ListTile(
      leading: widget.accountId != null
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
                widget.stepNumber,
                style: textTheme.bodySmall!
                    .apply(color: Theme.of(context).backgroundColor),
                textAlign: TextAlign.center,
              )),
            ),
      title: Text(widget.title, style: textTheme.bodyLarge),
      subtitle: Builder(builder: (context) {
        var isButtonDisable =
            input.controller!.text.isEmpty || widget.onDone == null;
        if (!widget.ready) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  appLocalizations.linkAccount_stepper_cif_label_creditsuisse,
                  style: textTheme.bodyMedium,
                ),
                const InfoIcon(),
              ],
            ),
            const SizedBox(height: 4),
            input,
            const SizedBox(height: 4),
            InkWell(
              onTap: isButtonDisable
                  ? null
                  : () => widget.onDone!(input.controller!.text),
              child: Text(
                widget.subtitle ?? '',
                style: textTheme.bodySmall!.apply(
                    color: isButtonDisable
                        ? Theme.of(context).cardColor
                        : Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        );
      }),
      trailing: Text(widget.trailing),
    );
  }
}
