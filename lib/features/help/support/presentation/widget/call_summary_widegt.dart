import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/help/support/data/models/meeting_type.dart';
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
              title: appLocalizations.scheduleMeeting_labels_callDetails,
              child: Column(
                children: [
                  CallSummaryRow(
                      label: appLocalizations.scheduleMeeting_labels_timeZone,
                      value: formState != null
                          ? TimeZones.getTimeZones(appLocalizations)
                              .firstWhere(
                                  (element) =>
                                      element.value ==
                                      formState!.value["timeZone"]?.value,
                                  orElse: () => TimeZones(
                                      name: "null",
                                      value: "null",
                                      offset: "null"))
                              .offset
                          // formState!.value["timeZoneOffset"].toString()
                          : "null"),
                  CallSummaryRow(
                    label: appLocalizations.scheduleMeeting_labels_date,
                    value: formState != null
                        ? formState!.instantValue["date"] != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(formState!.instantValue["date"])
                            : "null"
                        : "null",
                  ),
                  CallSummaryRow(
                      label: appLocalizations.scheduleMeeting_labels_time,
                      value: formState != null
                          ? formState!.instantValue["time"]
                              .toString()
                              .split(" ")[0]
                          : "null"),
                  CallSummaryRow(
                    label: appLocalizations.scheduleMeeting_labels_meetingType,
                    value: appLocalizations
                        .scheduleMeeting_meetingType_options_virtualMeeting,
                    // value: formState != null
                    //     ? formState!.instantValue["type"]
                    //     : "Virtual Meeting",
                  ),
                  CallSummaryRow(
                    label: appLocalizations.scheduleMeeting_labels_email,
                    value: (personalState is PersonalInformationLoaded)
                        ? personalState.getNameEntity.email
                        : "null",
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          CallSummarySection(
            title: appLocalizations.scheduleMeeting_labels_callSpecifications,
            child: CallSummaryRow(
              label: appLocalizations.scheduleMeeting_labels_reason,
              value: formState != null
                  ? formState!.value["subject"] != null
                      ? formState!.value["subject"] ??
                          appLocalizations.scheduleMeeting_text_notSpecified
                      : appLocalizations.scheduleMeeting_text_notSpecified
                  : appLocalizations.scheduleMeeting_text_notSpecified,
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
    final responsiveHelper = ResponsiveHelper(context: context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.bodyMedium,
            ),
            if (value != "null" && label == "Reason")
              SizedBox(
                  width: responsiveHelper.isMobile
                      ? responsiveHelper.optimalDeviceWidth * 0.65
                      : responsiveHelper.optimalDeviceWidth * 0.3,
                  child: Text(
                    value,
                    style: textTheme.titleSmall,
                    textAlign: TextAlign.end,
                  )),
            if (value != "null" && label != "Reason")
              Text(
                value,
                style: textTheme.titleSmall,
                textAlign: TextAlign.end,
              ),
            if (value == "null")
              Text(appLocalizations.scheduleMeeting_text_missing),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
