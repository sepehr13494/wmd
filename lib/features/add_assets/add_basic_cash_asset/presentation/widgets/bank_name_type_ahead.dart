import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/presentation/manager/manual_bank_list_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../core/data/models/listed_security_name.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BankNameTypeAhead extends StatefulWidget {
  final String name;
  final String? title;
  final String hint;
  final String? errorMsg;
  final ValueChanged<String?>? onChange;
  final bool? required;
  final List<String? Function(String?)>? extraValidators;
  final bool enabled;

  const BankNameTypeAhead({
    Key? key,
    required this.name,
    // required this.items,
    required this.hint,
    this.extraValidators,
    this.required = true,
    this.title,
    this.errorMsg,
    this.onChange,
    this.enabled = true,
  }) : super(key: key);

  @override
  AppState<BankNameTypeAhead> createState() =>
      _BankNameTypeAheadState();
}

class _BankNameTypeAheadState extends AppState<BankNameTypeAhead> {
  TextEditingController typeController = TextEditingController();
  final validators = <String? Function(String?)>[];
  Timer? timer;
  bool readyToSend = true;
  List<String> items = [];
  int waitingTime = 1;


  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {

    if (widget.required ?? false) {
      validators.add(FormBuilderValidators.required(
          errorText: widget.errorMsg ??
              (widget.title != null
                  ? 'Please enter ${widget.title!.toLowerCase()}'
                  : appLocalizations.common_errors_required)));
    }

    return FormBuilderField<String?>(
      decoration: const InputDecoration(
        prefixIcon:
        Icon(
          Icons.search,
        ),
      ),
      builder: (state) {
        if (typeController.text.isEmpty) {
          if (state.value != null) {
            typeController.text = state.value! ?? "";
          }
        }
        return BlocProvider(
          create: (context) => sl<ManualBankListCubit>(),
          child: Builder(
            builder: (context) {
              return BlocConsumer<ManualBankListCubit, ManualBankListState>(
                listener: (context, bankState) {
                  if (bankState is GetManualListLoaded) {
                    items = bankState.getManualListEntities.map((e) => e.bankName).toList();
                  }
                },
                builder: (context, bankState) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TypeAheadField(
                          animationStart: 0,
                          animationDuration: Duration.zero,
                          textFieldConfiguration: TextFieldConfiguration(
                            onChanged: (value) {
                              if(timer != null){
                                readyToSend = false;
                                timer!.cancel();
                              }
                              timer = Timer(Duration(seconds: waitingTime), () {
                                readyToSend = true;
                              });
                            },
                            style: TextStyle(
                                color: widget.enabled
                                    ? null
                                    : Theme.of(context).disabledColor),
                            enabled: widget.enabled,
                            decoration: InputDecoration(
                              hintText: widget.hint,
                              enabledBorder: state.hasError
                                  ? const OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ))
                                  : OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4)),
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: widget.enabled
                                      ? Theme.of(context).hintColor
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                            controller: typeController,
                          ),
                          keepSuggestionsOnLoading: false,
                          suggestionsCallback: (p0) async {
                            print("umad");
                            if(p0.length<3 && p0.isNotEmpty){
                              return [];
                            }else{
                              await Future.delayed(Duration(seconds: waitingTime,milliseconds: 100));
                              if(readyToSend){
                                // ignore: use_build_context_synchronously
                                await context.read<ManualBankListCubit>().getManualList(text: p0);
                                await Future.delayed(const Duration(milliseconds: 200));
                              }
                              return items;
                            }

                          },
                          loadingBuilder: (context) => const LoadingWidget(),
                          itemBuilder: (context, suggestion) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            typeController.text = suggestion;
                            state.didChange(suggestion);
                          },
                        ),
                        if (state.hasError) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 9),
                            child: Text(
                              state.errorText ?? "",
                              style:
                              TextStyle(fontSize: 12, color: Colors.red[600]),
                            ),
                          ),
                        ]
                      ]);
                },
              );
            }
          ),
        );
      },
      onChanged: widget.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(validators),
      name: widget.name,
    );
  }
}
