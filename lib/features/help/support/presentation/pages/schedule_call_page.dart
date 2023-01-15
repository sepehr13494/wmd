import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
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
import 'package:wmd/features/help/support/presentation/widget/schedule_call_footer.dart';
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
    return BlocProvider(
      create: (context) => sl<RealEstateCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(
            title: ".",
          ),
          bottomSheet: ScheduleCallFooter(
              formKey: formKey,
              onTap: !enableAddAssetButton
                  ? null
                  : () {
                      Map<String, dynamic> finalMap = {
                        ...formKey.currentState!.instantValue,
                      };

                      print(finalMap);

                      context
                          .read<RealEstateCubit>()
                          .postRealEstate(map: finalMap);
                    }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<RealEstateCubit, RealEstateState>(
                        listener: AssetBlocHelper.defaultBlocListener(
                            listener: (context, state) {},
                            asset: "Real estate"),
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(children: [
                              FormBuilder(
                                key: formKey,
                                initialValue:
                                    AddAssetConstants.initialJsonForAddAsset,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appLocalizations
                                          .support_card_contactClientService_title,
                                      style: textTheme.headlineMedium,
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
                                          await Future.delayed(const Duration(
                                              milliseconds: 200));
                                          checkFinalValid(val);
                                        },
                                        name: "timezone",
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
                                        selectableDayPredicate:
                                            (DateTime date) {
                                          if (date.weekday ==
                                                  DateTime.saturday ||
                                              date.weekday == DateTime.friday) {
                                            return false;
                                          }
                                          return true;
                                        },
                                        name: "date",
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                          await Future.delayed(const Duration(
                                              milliseconds: 200));
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
                                      child: AppTextFields.simpleTextField(
                                          title: "Address",
                                          name: "address",
                                          required: false,
                                          // onChanged: checkFinalValid,
                                          hint: "Address"),
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
                                          await Future.delayed(const Duration(
                                              milliseconds: 200));
                                          checkFinalValid(val);
                                        },
                                        name: "reason",
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
                                          name: "reason",
                                          minLines: 5,
                                          onChanged: checkFinalValid,
                                          extraValidators: [
                                            (val) {
                                              return (val != null &&
                                                      val.length > 100)
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
                            ]),
                          );
                        });
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
