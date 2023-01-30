import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/help/support/data/models/time_zones.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';

class CallSummaryWidget extends AppStatelessWidget {
  final FormBuilderState? formState;

  const CallSummaryWidget({required this.formState, Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Builder(builder: (context) {
      final PersonalInformationState personalState =
          context.watch<PersonalInformationCubit>().state;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CallSummarySection(
              title: "Call details",
              child: Column(
                children: [
                  CallSummaryRow(
                      label: "Time Zone*",
                      value: formState != null
                          ? TimeZones.timezonesList
                              .firstWhere(
                                  (element) =>
                                      element.value ==
                                      formState!.value["timeZone"],
                                  orElse: () => TimeZones(
                                      name: "null",
                                      value: "null",
                                      offset: "null"))
                              .offset
                          // formState!.value["timeZoneOffset"].toString()
                          : "null"),
                  CallSummaryRow(
                    label: "Date*",
                    value: formState != null
                        ? formState!.instantValue["date"] != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(formState!.instantValue["date"])
                            : "null"
                        : "null",
                  ),
                  CallSummaryRow(
                      label: "Time*",
                      value: formState != null
                          ? formState!.instantValue["time"].toString()
                          : "null"),
                  CallSummaryRow(
                    label: "Meeting type",
                    value: formState != null
                        ? formState!.instantValue["type"]
                        : "null",
                  ),
                  CallSummaryRow(
                    label: "Email*",
                    value: formState != null
                        ? (personalState is PersonalInformationLoaded)
                            ? personalState.getNameEntity.email
                            : "null"
                        : "null",
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
              value: formState != null
                  ? formState!.value["subject"] ?? "Not specified"
                  : "Not specified",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    });
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
