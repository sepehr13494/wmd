import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/request_new_custodian/data/models/request_new_custodian_params.dart';
import 'package:wmd/features/add_assets/request_new_custodian/presentation/manager/request_new_custodian_cubit.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

Future<void> showNewCustodianModal({
  required BuildContext context,
}) async {
  return await showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: BlocProvider.of<PersonalInformationCubit>(context),
        child: const CenterModalWidget(
          body: RequestCustodianForm(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          actions: SizedBox(),
        ),
      );
    },
  );
}

class RequestCustodianForm extends StatefulWidget {
  const RequestCustodianForm({
    Key? key,
  }) : super(key: key);

  @override
  AppState<RequestCustodianForm> createState() => _RequestCustodianFormState();
}

class _RequestCustodianFormState extends AppState<RequestCustodianForm> {
  bool checkbox = false;
  final _formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = _formKey.currentState!.isValid;
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
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final validator = FormBuilderValidators.compose([
      FormBuilderValidators.required(
          errorText: appLocalizations.common_errors_required),
    ]);


    return BlocProvider(
      create: (context) => sl<RequestNewCustodianCubit>(),
      child: BlocConsumer<RequestNewCustodianCubit, RequestNewCustodianState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pop(context, true);
              GlobalFunctions.showSnackTile(context,
                  title: appLocalizations
                      .common_newCustodianRequest_modal_confirmation);
            } else {
              GlobalFunctions.showSnackTile(context,
                  title: appLocalizations.common_errors_somethingWentWrong,
                  color: Colors.red);
            }
          }), builder: (context, state) {
        return FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    appLocalizations.common_newCustodianRequest_modal_title,
                    style: textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Text(appLocalizations
                    .common_newCustodianRequest_modal_bankDetails),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'accountNumber',
                  decoration: InputDecoration(
                    labelText: appLocalizations
                        .common_newCustodianRequest_modal_accountNumber,
                    filled: true,
                    fillColor: AppColors.bgColor,
                    border: InputBorder.none,
                  ),
                  onChanged: checkFinalValid,
                  validator: validator,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'bankName',
                  decoration: InputDecoration(
                    labelText: appLocalizations
                        .common_newCustodianRequest_modal_bankName,
                    filled: true,
                    fillColor: AppColors.bgColor,
                    border: InputBorder.none,
                  ),
                  onChanged: checkFinalValid,
                  validator: validator,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                FormBuilderDropdown(
                  name: 'country',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validator,
                  onChanged: checkFinalValid,
                  items: Country.getCountryList(context)
                      .map((e) =>
                      DropdownMenuItem(
                        value: e.countryName,
                        child: Text(e.countryName),
                      ))
                      .toList(),
                  decoration: InputDecoration(
                    labelText: appLocalizations
                        .common_newCustodianRequest_modal_bankCountry,
                    filled: true,
                    fillColor: AppColors.bgColor,
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 24),
                Text(appLocalizations
                    .common_newCustodianRequest_modal_managerDetails),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'rmName',
                  onChanged: checkFinalValid,
                  decoration: InputDecoration(
                    labelText: appLocalizations
                        .common_newCustodianRequest_modal_managerName,
                    filled: true,
                    fillColor: AppColors.bgColor,
                    border: InputBorder.none,
                  ),
                  validator: validator,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'rmEmail',
                  onChanged: checkFinalValid,
                  decoration: InputDecoration(
                    labelText: appLocalizations
                        .common_newCustodianRequest_modal_managerEmail,
                    filled: true,
                    fillColor: AppColors.bgColor,
                    border: InputBorder.none,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validator,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                Card(
                  color: AppColors.blueCardColor,
                  margin: const EdgeInsets.all(0),
                  child: FormBuilderCheckbox(
                    name: 'consent',
                    selected: checkbox,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: appLocalizations.common_errors_required),
                      FormBuilderValidators.notEqual(false,
                          errorText: appLocalizations.common_errors_required),
                    ]),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          checkbox = val;
                        });
                        checkFinalValid(val);
                      }
                    },
                    title: Text(
                      appLocalizations.common_newCustodianRequest_modal_check,
                      style: textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: !enableAddAssetButton ? null : () {
                        if (_formKey.currentState!.validate()) {
                          final PersonalInformationState personalState = BlocProvider.of<PersonalInformationCubit>(context, listen: false).state;
                          final String name = personalState is PersonalInformationLoaded
                              ? personalState.getNameEntity.email
                              : "";

                          print(_formKey.currentState!.value);
                          context
                              .read<RequestNewCustodianCubit>()
                              .requestNewCustodian(
                              RequestNewCustodianParams.fromJson(
                                  _formKey.currentState!.value, name));
                        } else {
                          print('Can not check valid');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      child: Text(appLocalizations.common_button_submit),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
