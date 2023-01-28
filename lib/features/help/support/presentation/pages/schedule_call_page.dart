import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/real_estate_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/help/support/data/models/call_reason.dart';
import 'package:wmd/features/help/support/data/models/meeting_type.dart';
import 'package:wmd/features/help/support/data/models/time_zones.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';
import 'package:wmd/features/help/support/presentation/widget/call_summary_widegt.dart';
import 'package:wmd/features/help/support/presentation/widget/schedule_call_footer.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class ScheduleCallPage extends StatefulWidget {
  const ScheduleCallPage({Key? key}) : super(key: key);
  @override
  AppState<ScheduleCallPage> createState() => _ScheduleCallPageState();
}

class _ScheduleCallPageState extends AppState<ScheduleCallPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  DateTime? availableDateValue;
  @override
  void didUpdateWidget(covariant ScheduleCallPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
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
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);

    return BlocProvider(
      create: (context) => sl<GeneralInquiryCubit>(),
      child: BlocConsumer<GeneralInquiryCubit, GeneralInquiryState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
        if (state is SuccessState) {
          GlobalFunctions.showSnackBar(context, "Call sheduled successfully!",
              type: "success");
          Navigator.pop(context);
        }
      }), builder: (context, state) {
        final PersonalInformationState personalState =
            context.watch<PersonalInformationCubit>().state;

        return Scaffold(
          appBar: const AddAssetHeader(
            title: "",
          ),
          bottomSheet: !responsiveHelper.isMobile
              ? null
              : ScheduleCallFooter(
                  formKey: formKey,
                  onTap: !enableAddAssetButton
                      ? null
                      : () {
                          Map<String, dynamic> finalMap = {
                            ...formKey.currentState!.instantValue,
                            "email":
                                (personalState is PersonalInformationLoaded)
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
                        }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                Builder(builder: (context) {
                  return BlocConsumer<GeneralInquiryCubit, GeneralInquiryState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return responsiveHelper.isMobile
                            ? WidthLimiterWidget(
                                child: SingleChildScrollView(
                                    child: renderForm(
                                        context, textTheme, appLocalizations)))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  WidthLimiterWidget(
                                      width:
                                          responsiveHelper.optimalDeviceWidth *
                                              0.45,
                                      child: SingleChildScrollView(
                                          child: renderForm(context, textTheme,
                                              appLocalizations))),
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
                                                          const EdgeInsets.all(
                                                              28),
                                                      child: Column(
                                                        children: [
                                                          CallSummaryWidget(
                                                              formKey: formKey),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Map<String,
                                                                        dynamic>
                                                                    finalMap = {
                                                                  ...formKey
                                                                      .currentState!
                                                                      .instantValue,
                                                                };

                                                                print(finalMap);

                                                                context
                                                                    .read<
                                                                        GeneralInquiryCubit>()
                                                                    .postScheduleCall(
                                                                        map:
                                                                            finalMap);
                                                              },
                                                              child: const Text(
                                                                  "Schedule a call"))
                                                        ],
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                Text(
                                                  "* Indicates a required field",
                                                  style: textTheme.titleMedium,
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
      }),
    );
  }

  Widget renderForm(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return Builder(builder: (context) {
      final PersonalInformationState personalState =
          context.watch<PersonalInformationCubit>().state;

      return Column(children: [
        FormBuilder(
          key: formKey,
          initialValue: {
            "type": "Virtual Meeting",
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
                title: "Select your time zone",
                child: AppTextFields.dropDownTextField(
                  onChanged: (val) async {
                    // setState(() {
                    //   bottomFormKey =
                    //       GlobalKey<FormBuilderState>();
                    //   accountType = val;
                    // });
                    await Future.delayed(const Duration(milliseconds: 200));
                    checkFinalValid(val);
                  },
                  name: "timeZone",
                  hint: "Select",
                  items: TimeZones.timezonesList
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.name),
                          ))
                      .toList(),
                ),
              ),
              EachTextField(
                title: "Select an available date",
                child: FormBuilderDateTimePicker(
                  onChanged: (selectedDate) {
                    checkFinalValid(selectedDate);
                    setState(() {
                      availableDateValue = selectedDate;
                    });
                  },
                  firstDate: DateTime.now(),
                  inputType: InputType.date,
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
                      hintText: "DD/MM/YYYY"),
                ),
              ),
              if (availableDateValue != null)
                const EachTextField(
                    title: "Select an available date",
                    child: TimeslotsSelector<String>(
                      name: "time",
                    )),
              EachTextField(
                hasInfo: false,
                title: "Meeting type",
                child: AppTextFields.dropDownTextField(
                  onChanged: (val) async {
                    await Future.delayed(const Duration(milliseconds: 200));
                    checkFinalValid(val);
                  },
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
                title: "Email",
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
                title: "Call reason",
                child: AppTextFields.dropDownTextField(
                  onChanged: (val) async {
                    // setState(() {
                    //   bottomFormKey =
                    //       GlobalKey<FormBuilderState>();
                    //   accountType = val;
                    // });
                    await Future.delayed(const Duration(milliseconds: 200));
                    checkFinalValid(val);
                  },
                  name: "subject",
                  hint: "Select",
                  items: CallReason.callReasonList
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.name),
                          ))
                      .toList(),
                ),
              ),
              EachTextField(
                hasInfo: false,
                title: "Additional Info",
                child: AppTextFields.simpleTextField(
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
