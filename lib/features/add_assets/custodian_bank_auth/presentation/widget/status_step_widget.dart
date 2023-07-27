import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusStepWidget extends StatefulWidget {
  final String stepNumber;
  final Widget title;
  final bool isDone;
  final bool isActive;
  final bool showAction;
  final Widget? subtitle;
  final String? doneSubtitle;
  final Widget? trailing;
  final void Function(String? val)? onDone;
  final void Function()? onDoneAgain;
  const StatusStepWidget({
    required this.title,
    required this.stepNumber,
    this.trailing,
    this.isDone = false,
    this.isActive = false,
    this.showAction = false,
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
          // widget.isDone
          //     ? const Icon(Icons.check_circle)
          //     :
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isActive == true
                    ? Theme.of(context).primaryColor
                    : Colors.grey[500],
              ),
              height: 20,
              width: 20,
              child: Center(
                  child: Text(
                widget.stepNumber,
                style: textTheme.bodySmall!
                    .apply(color: Theme.of(context).backgroundColor),
                textAlign: TextAlign.center,
              )),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(flex: 8, child: widget.title),

          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: (widget.showAction == true && !widget.isDone)
                ? widget.isActive
                    ? OutlinedButton(
                        onPressed: () => widget.onDone!(""),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(50, 40),
                          // maximumSize: const Size(130, 80)
                        ),
                        child: Text(
                          appLocalizations.common_button_markAsDone,
                          style: textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 10),
                        ),
                      )
                    : const SizedBox.shrink()
                : widget.isDone
                    ? widget.trailing ??
                        Icon(
                          Icons.check_circle_outline,
                          color: Theme.of(context).primaryColor,
                        )
                    : const SizedBox.shrink(),
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
                  child: widget.subtitle!,
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
  final bool isActive;
  final bool? isDone;
  final String trailing;
  final void Function(String? val)? onDone;
  final void Function()? onDoneAgain;
  const CifStatusWidget({
    required this.title,
    required this.stepNumber,
    required this.trailing,
    required this.bankId,
    this.isActive = true,
    this.isDone,
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
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isActive == true
                  ? Theme.of(context).primaryColor
                  : Colors.grey[500],
            ),
            height: 20,
            width: 20,
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
              style: textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 4),
          //   child: Text(widget.trailing, style: textTheme.bodySmall),
          // )
          if (widget.isDone == true)
            Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).primaryColor,
                ))
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 26.0),
        child: Builder(builder: (context) {
          var isButtonDisable = input.text.isEmpty || widget.onDone == null;
          // if (!widget.ready) {
          //   return const SizedBox();
          // }
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
            case 'pictet':
              message = appLocalizations.linkAccount_stepper_cif_label_pictet;
              tooltip = appLocalizations.linkAccount_stepper_cif_tooltip_pictet;
              break;
            default:
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      enabled: widget.accountId == null && widget.isActive,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.isDone != true)
                    OutlinedButton(
                      onPressed: () => widget.onDone!(input.text),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(50, 40),
                        // maximumSize: const Size(130, 80)
                      ),
                      child: Text(
                        widget.subtitle ?? '',
                        style: textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 10),
                      ),
                    ),
                  if (widget.accountId != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4, top: 8, right: 40),
                      child: InkWell(
                        onTap: widget.isDone == true
                            ? null
                            : () => widget.onDone!(input.text),
                        child: Text(
                          appLocalizations.common_button_edit,
                          style: textTheme.bodySmall!.apply(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                ],
              ),
              // const SizedBox(height: 4),
            ],
          );
        }),
      ),
      // trailing: Text(widget.trailing),
    );
  }
}
