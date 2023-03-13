import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/help/support/data/models/call_reason.dart';
import 'package:wmd/features/help/support/data/models/meeting_type.dart';
import 'package:wmd/features/help/support/data/models/time_zones.dart';

class ValuationFormWidget extends StatefulWidget {
  const ValuationFormWidget({Key? key}) : super(key: key);
  @override
  AppState<ValuationFormWidget> createState() => _ValuationFormWidgetState();
}

class _ValuationFormWidgetState extends AppState<ValuationFormWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;
  FormBuilderState? formState;

  @override
  void didUpdateWidget(covariant ValuationFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    setState(() {
      formState = formKey.currentState;
    });

    if (finalValid) {
      if (!enableAddAssetButton) {
        setState(() {
          enableAddAssetButton = true;
        });
      }
    } else {
      if (enableAddAssetButton) {
        setState(() {
          enableAddAssetButton = false;
        });
      }
    }
    formState?.save();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Column(children: [
      FormBuilder(
        key: formKey,
        // initialValue: {
        //   "type": "Virtual Meeting",
        //   "email": (personalState is PersonalInformationLoaded)
        //       ? personalState.getNameEntity.email
        //       : ""
        // },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.support_card_contactClientService_title,
              style: responsiveHelper.isMobile
                  ? textTheme.headlineMedium
                  : textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.scheduleMeeting_timeZone_label,
              child: FormBuilderSearchableDropdown<TimeZones>(
                name: "timeZone",
                hint: "Select",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                items: TimeZones.timezonesList,
                onChanged: (val) async {
                  // setState(() {
                  //   bottomFormKey =
                  //       GlobalKey<FormBuilderState>();
                  //   accountType = val;
                  // });
                  if (val != null) {
                    setState(() {
                      hasTimeLineSelected = true;
                    });
                  } else {
                    setState(() {
                      hasTimeLineSelected = false;
                    });
                  }

                  await Future.delayed(const Duration(milliseconds: 200));
                  checkFinalValid(val);
                },
                itemAsString: (TimeZones val) => val.name,
                filterFn: (currency, string) {
                  return (currency.name
                      .toLowerCase()
                      .contains(string.toLowerCase()));
                },
                itemBuilder: (context, currency, _) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(currency.name),
                  );
                },
              ),
            ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.scheduleMeeting_availableDate_label,
              child: FormBuilderDateTimePicker(
                onChanged: (selectedDate) {
                  checkFinalValid(selectedDate);
                  setState(() {
                    availableDateValue = selectedDate;
                  });
                },
                enabled: hasTimeLineSelected,
                firstDate: DateTime.now(),
                lastDate: Jiffy(DateTime.now()).add(months: 6).dateTime,
                inputType: InputType.date,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                format: DateFormat("dd/MM/yyyy"),
                selectableDayPredicate: (DateTime date) {
                  if (date.weekday == DateTime.saturday ||
                      date.weekday == DateTime.friday) {
                    return false;
                  }
                  return true;
                },
                name: "date",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: appLocalizations
                        .scheduleMeeting_availableDate_placeholder),
              ),
            ),
            if (availableDateValue != null)
              EachTextField(
                  hasInfo: false,
                  title:
                      appLocalizations.scheduleMeeting_availableTimeSlots_label,
                  child: TimeslotsSelector<String>(
                    name: "time",
                    onChanged: (val) => checkFinalValid(val),
                  )),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.scheduleMeeting_meetingType_label,
              child: AppTextFields.dropDownTextField(
                onChanged: (val) async {
                  await Future.delayed(const Duration(milliseconds: 200));
                  checkFinalValid(val);
                },
                fontSize: 13.5,
                name: "type",
                enabled: false,
                hint: "Select",
                items: MeetingType.meetingTypeList
                    .map((e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.name),
                        ))
                    .toList(),
              ),
            ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.scheduleMeeting_callReason_label,
              child: FormBuilderSearchableDropdown<CallReason>(
                name: "subject",
                hint: "Select",
                showSearchBox: false,
                onChanged: checkFinalValid,
                items: CallReason.callReasonList(context),
                itemAsString: (CallReason val) => val.name,
                itemBuilder: (context, currency, _) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(currency.name),
                  );
                },
              ),
            ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.scheduleMeeting_additionalInfo_label,
              child: AppTextFields.simpleTextField(
                  required: false,
                  title: "info",
                  name: "content",
                  minLines: 5,
                  onChanged: checkFinalValid,
                  extraValidators: [
                    (val) {
                      return (val != null && val.length > 100)
                          ? "Inquiry cannot be more than 100 characters"
                          : null;
                    }
                  ],
                  hint: appLocalizations
                      .common_submitEnquiryModal_textarea_placeholder),
            ),
            const SizedBox(height: 120),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    ]);
  }
}
