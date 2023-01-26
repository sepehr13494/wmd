import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CallSummaryWidget extends AppStatelessWidget {
  final GlobalKey<FormBuilderState> formKey;

  const CallSummaryWidget({required this.formKey, Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CallSummarySection(
            title: "Call details",
            child: Column(
              children: [
                CallSummaryRow(
                    label: "Time Zone",
                    value: formKey.currentState!.instantValue["timezone"]
                        .toString()),
                CallSummaryRow(
                  label: "Date",
                  value: DateFormat('yyyy-MM-dd')
                      .format(formKey.currentState!.instantValue["date"]),
                ),
                CallSummaryRow(
                    label: "Time",
                    value:
                        formKey.currentState!.instantValue["time"].toString()),
                CallSummaryRow(
                  label: "Meeting type",
                  value:
                      formKey.currentState!.instantValue["type"] ?? "Missing",
                ),
                CallSummaryRow(
                  label: "Email",
                  value: formKey.currentState!.instantValue["email"].toString(),
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
            value:
                formKey.currentState!.instantValue["reason"] ?? "Not specified",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
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
