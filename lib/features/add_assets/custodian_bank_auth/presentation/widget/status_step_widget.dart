import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return ListTile(
      // leading:,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isDone
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
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: Text(
              widget.title,
              style: textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(widget.trailing, style: textTheme.bodySmall),
          )
        ],
      ),
      subtitle: Builder(
        builder: (context) {
          if (widget.isDone) {
            if (widget.doneSubtitle != null) {
              return Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: InkWell(
                  onTap: widget.onDoneAgain,
                  child: Text(
                    widget.doneSubtitle!,
                    style: textTheme.bodySmall!.apply(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              );
            }
          } else {
            if (widget.subtitle != null) {
              return Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: InkWell(
                  onTap:
                      widget.onDone == null ? null : () => widget.onDone!(null),
                  child: Text(
                    widget.subtitle!,
                    style: textTheme.bodySmall!.apply(
                        color: widget.onDone == null
                            ? Theme.of(context).primaryColor.withOpacity(0.4)
                            : Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
      // trailing: Text(widget.trailing),
    );
  }
}

class CifStatusWidget extends StatefulWidget {
  final String stepNumber;
  final String title;
  final String bankId;
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
    required this.bankId,
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
  late final TextEditingController input;
  var isButtonDisable = false;

  @override
  void initState() {
    super.initState();
    input = TextEditingController(text: widget.accountId)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    isButtonDisable =
        widget.accountId != null && input.text.isEmpty && widget.onDone != null;
    return ListTile(
      // leading:
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.accountId != null
              ? const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 18,
                )
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
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: Text(
              widget.title,
              style: textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(widget.trailing, style: textTheme.bodySmall),
          )
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 26.0),
        child: Builder(builder: (context) {
          var isButtonDisable = input.text.isEmpty || widget.onDone == null;
          if (!widget.ready) {
            return const SizedBox();
          }
          String message =
              appLocalizations.linkAccount_stepper_cif_label_creditsuisse;
          String tooltip =
              appLocalizations.linkAccount_stepper_cif_tooltip_creditsuisse;

          switch (widget.bankId) {
            case 'hsbc':
              message = appLocalizations.linkAccount_stepper_cif_label_hsbc;
              tooltip = appLocalizations.linkAccount_stepper_cif_tooltip_hsbc;
              break;
            case 'juliusbar':
              message =
                  appLocalizations.linkAccount_stepper_cif_label_juliusbar;
              tooltip =
                  appLocalizations.linkAccount_stepper_cif_tooltip_juliusbar;
              break;
            case 'jpmorgan':
              message = appLocalizations.linkAccount_stepper_cif_label_jpmorgan;
              tooltip =
                  appLocalizations.linkAccount_stepper_cif_tooltip_jpmorgan;
              break;
            case 'lombardodier':
              message =
                  appLocalizations.linkAccount_stepper_cif_label_lombardodier;
              tooltip =
                  appLocalizations.linkAccount_stepper_cif_tooltip_lombardodier;
              break;
            case 'ubs':
              message = appLocalizations.linkAccount_stepper_cif_label_ubs;
              tooltip = appLocalizations.linkAccount_stepper_cif_tooltip_ubs;
              break;
            default:
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      message,
                      style: textTheme.bodyMedium,
                    ),
                    // const InfoIcon(),
                    const SizedBox(width: 4),
                    Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      textAlign: TextAlign.center,
                      message: tooltip,
                      child: const InfoIcon(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: appLocalizations
                              .linkAccount_stepper_cif_placeholder),
                      controller: input,
                      enabled: widget.accountId == null,
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap:
                    isButtonDisable ? null : () => widget.onDone!(input.text),
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
      ),
      // trailing: Text(widget.trailing),
    );
  }
}
