import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduleCallFooter extends StatefulWidget {
  final void Function()? onTap;
  final GlobalKey<FormBuilderState> formKey;

  const ScheduleCallFooter({
    Key? key,
    required this.onTap,
    required this.formKey,
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
      height: isExpandedFooter ? 500 : 120,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CallSummarySection(
                          title: "Call details",
                          child: Column(
                            children: [
                              CallSummaryRow(
                                  label: "Time Zone",
                                  value: widget.formKey.currentState!
                                      .instantValue["timezone"]
                                      .toString()),
                              CallSummaryRow(
                                label: "Date",
                                value: widget
                                    .formKey.currentState!.instantValue["date"]
                                    .toString(),
                              ),
                              CallSummaryRow(
                                  label: "Time",
                                  value: widget.formKey.currentState!
                                      .instantValue["time"]
                                      .toString()),
                              CallSummaryRow(
                                label: "Meeting type",
                                value: widget.formKey.currentState!
                                        .instantValue["type"] ??
                                    "Missing",
                              ),
                              CallSummaryRow(
                                label: "Email",
                                value: widget
                                    .formKey.currentState!.instantValue["date"]
                                    .toString(),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      CallSummarySection(
                        title: "Call specification",
                        child: CallSummaryRow(
                          label: "Reason",
                          value: widget.formKey.currentState!
                                  .instantValue["reason"] ??
                              "Not specified",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
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
                                  child: const Text("Schedule a call"))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}

class CallSummarySection extends AppStatelessWidget {
  final String title;
  final Widget child;

  const CallSummarySection({required this.title, required this.child, Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 20,
        ),
        Divider(
          height: 0.5,
          thickness: 1,
          color: Theme.of(context).dividerColor,
        ),
        const SizedBox(
          height: 20,
        ),
        child
      ],
    );
  }
}

class CallSummaryRow extends AppStatelessWidget {
  final String label;
  final String value;

  const CallSummaryRow({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.bodyMedium,
            ),
            if (value != "null")
              Text(
                value,
                style: textTheme.titleSmall,
              ),
            if (value == "null") const Text("Missing"),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
