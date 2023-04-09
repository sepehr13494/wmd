import 'dart:developer';

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
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/help/support/data/models/call_reason.dart';
import 'package:wmd/features/help/support/data/models/meeting_type.dart';
import 'package:wmd/features/help/support/data/models/time_zones.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';
import 'package:wmd/features/help/support/presentation/widget/call_summary_widegt.dart';
import 'package:wmd/features/help/support/presentation/widget/schedule_call_footer.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/injection_container.dart';

class ScheduleCallPage extends StatefulWidget {
  const ScheduleCallPage({Key? key}) : super(key: key);
  @override
  AppState<ScheduleCallPage> createState() => _ScheduleCallPageState();
}

class _ScheduleCallPageState extends AppState<ScheduleCallPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;
  FormBuilderState? formState;

  @override
  void didUpdateWidget(covariant ScheduleCallPage oldWidget) {
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

    return BlocProvider(
      create: (context) => sl<GeneralInquiryCubit>(),
      child: BlocConsumer<GeneralInquiryCubit, GeneralInquiryState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
        debugPrint(state.toString());

        if (state is ErrorState) {
          GlobalFunctions.showSnackBar(context, state.failure.message,
              color: Colors.red[800], type: "error");
          Navigator.pop(context, false);
        }
      }), builder: (context, state) {
        final PersonalInformationState personalState =
            context.watch<PersonalInformationCubit>().state;

        if (state is SuccessState) {
          return SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: isMobile
                      ? MediaQuery.of(context).size.height * 0.7
                      : MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                      child: Column(children: [
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  textTheme.bodySmall!.color!.withOpacity(0.1),
                            ),
                            child: Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).primaryColor,
                              size: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            appLocalizations.scheduleMeeting_success_title,
                            style: textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      responsiveHelper.bigger16Gap * 3.5),
                              child: Text(
                                appLocalizations
                                    .scheduleMeeting_success_description,
                                style: textTheme.bodyMedium!
                                    .copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              )),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () => context.goNamed(AppRoutes.support),
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 50)),
                            child: Text(
                                appLocalizations.scheduleMeeting_button_close),
                          ),
                        ]))
                  ]))));
        } else {
          return Scaffold(
            appBar: const AddAssetHeader(
                title: "", goToRoute: AppRoutes.support, showExitModal: false),
            bottomSheet: !responsiveHelper.isMobile
                ? null
                : ScheduleCallFooter(
                    formState: formState,
                    onTap: () {
                      formKey.currentState?.validate();
                      if (enableAddAssetButton) {
                        Map<String, dynamic> finalMap = {
                          ...formKey.currentState!.instantValue,
                          "email": (personalState is PersonalInformationLoaded)
                              ? personalState.getNameEntity.email
                              : "",
                          "firstName":
                              (personalState is PersonalInformationLoaded)
                                  ? personalState.getNameEntity.firstName
                                  : "",
                          "lastName":
                              (personalState is PersonalInformationLoaded)
                                  ? personalState.getNameEntity.lastName
                                  : "",
                        };

                        print(finalMap);

                        context
                            .read<GeneralInquiryCubit>()
                            .postScheduleCall(map: finalMap);
                      }
                    }),
            body: Theme(
              data: Theme.of(context).copyWith(),
              child: Stack(
                children: [
                  const LeafBackground(),
                  Builder(builder: (context) {
                    return BlocConsumer<GeneralInquiryCubit,
                            GeneralInquiryState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return responsiveHelper.isMobile
                              ? WidthLimiterWidget(
                                  child: SingleChildScrollView(
                                      child: renderForm(context, textTheme,
                                          appLocalizations)))
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WidthLimiterWidget(
                                        width: responsiveHelper
                                                .optimalDeviceWidth *
                                            0.45,
                                        child: SingleChildScrollView(
                                            child: renderForm(context,
                                                textTheme, appLocalizations))),
                                    Container(
                                        constraints: BoxConstraints(
                                            maxWidth: responsiveHelper
                                                    .optimalDeviceWidth *
                                                0.55),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 28, horizontal: 24),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Card(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(28),
                                                        child: Column(
                                                          children: [
                                                            CallSummaryWidget(
                                                                formState:
                                                                    formState),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  Map<String,
                                                                          dynamic>
                                                                      finalMap =
                                                                      {
                                                                    ...formKey
                                                                        .currentState!
                                                                        .instantValue,
                                                                  };

                                                                  print(
                                                                      finalMap);

                                                                  context
                                                                      .read<
                                                                          GeneralInquiryCubit>()
                                                                      .postScheduleCall(
                                                                          map:
                                                                              finalMap);
                                                                },
                                                                child: Text(
                                                                    appLocalizations
                                                                        .scheduleMeeting_button_call))
                                                          ],
                                                        ),
                                                      )),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  Text(
                                                    appLocalizations
                                                        .scheduleMeeting_text_required,
                                                    style:
                                                        textTheme.titleMedium,
                                                  )
                                                ])))
                                  ],
                                );
                        });
                  }),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget renderForm(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return Builder(builder: (context) {
      final PersonalInformationState personalState =
          context.watch<PersonalInformationCubit>().state;
      // log('Mert log: ${DateTime.now().timeZoneName} and ${DateTime.now().timeZoneOffset}');
      return Column(children: [
        FormBuilder(
          key: formKey,
          initialValue: {
            "type": MeetingType.meetingTypeList.first.name,
            "email": (personalState is PersonalInformationLoaded)
                ? personalState.getNameEntity.email
                : ""
          },
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
                  hint: "",
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  initialValue: TimeZones.getTimezoneByDevice(appLocalizations),
                  items: TimeZones.getTimezonesListLocalized(appLocalizations),
                  // initialValue: ,
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
                    title: appLocalizations
                        .scheduleMeeting_availableTimeSlots_label,
                    child: TimeslotsSelector<String>(
                      name: "time",
                      isToday: availableDateValue?.isToday(),
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
                  enabled: false,
                  name: "type",
                  hint: "",
                  initial: MeetingType.meetingTypeList.first.value,
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
                title: appLocalizations.auth_forgot_input_email_label,
                child: TextField(
                  enabled: false,
                  style: TextStyle(color: Colors.grey[500]),
                  controller: TextEditingController(
                      text: (personalState is PersonalInformationLoaded)
                          ? personalState.getNameEntity.email
                          : ""),
                ),

                // AppTextFields.simpleTextField(
                //     title: "Address",
                //     name: "address",
                //     required: false,
                //     // onChanged: checkFinalValid,
                //     hint: "Address"),
              ),
              EachTextField(
                hasInfo: false,
                title: appLocalizations.scheduleMeeting_callReason_label,
                child: AppTextFields.simpleTextField(
                  required: false,
                  title: "subject",
                  name: "subject",
                  minLines: 1,
                  onChanged: checkFinalValid,
                  extraValidators: [
                    (val) {
                      return (val != null && val.length > 100)
                          ? "Inquiry cannot be more than 100 characters"
                          : null;
                    }
                  ],
                  hint: '',
                ),
                // child: FormBuilderSearchableDropdown<CallReason>(
                //   name: "subject",
                //   hint: "",
                //   showSearchBox: false,
                //   onChanged: checkFinalValid,
                //   items: CallReason.callReasonList(context),
                //   itemAsString: (CallReason val) => val.name,
                //   itemBuilder: (context, currency, _) {
                //     return Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Text(currency.name),
                //     );
                //   },
                // ),
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
    });
  }
}
