import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/help/support/presentation/widget/call_summary_widegt.dart';

class ScheduleCallFooter extends StatefulWidget {
  final void Function()? onTap;
  final FormBuilderState? formState;

  const ScheduleCallFooter({
    Key? key,
    required this.onTap,
    required this.formState,
  }) : super(key: key);
  @override
  AppState<ScheduleCallFooter> createState() => _ScheduleCallFooterState();
}

class _ScheduleCallFooterState extends AppState<ScheduleCallFooter> {
  bool isExpandedFooter = false;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;

    return Container(
      width: double.maxFinite,
      height: isExpandedFooter ? 512 : 120,
      color: Theme.of(context).cardColor,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isExpandedFooter = !isExpandedFooter;
                    });
                  },
                  icon: Icon(
                    isExpandedFooter
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Theme.of(context).primaryColor,
                  )),
              if (isExpandedFooter)
                SizedBox(
                    width: double.infinity,
                    child: CallSummaryWidget(formState: widget.formState)),
              Row(
                children: [
                  ExpandedIf(
                    expanded: isMobile,
                    child: SizedBox(
                      width: isMobile ? double.maxFinite : 300,
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    widget.onTap!();
                                  },
                                  child: Text(appLocalizations
                                      .scheduleMeeting_header_title))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              )
            ],
          )),
    );
  }
}
