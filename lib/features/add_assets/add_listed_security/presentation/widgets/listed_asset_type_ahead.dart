import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../core/data/models/listed_security_name.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListedSecurityTypeAhead extends StatefulWidget {
  final String name;
  final String? title;
  final String hint;
  final String? errorMsg;
  final ValueChanged<ListedSecurityName?>? onChange;
  final bool? required;
  final List<String? Function(String?)>? extraValidators;
  final bool enabled;

  const ListedSecurityTypeAhead({
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
  AppState<ListedSecurityTypeAhead> createState() =>
      _ListedSecurityTypeAheadState();
}

class _ListedSecurityTypeAheadState extends AppState<ListedSecurityTypeAhead> {
  TextEditingController typeController = TextEditingController();
  final validators = <String? Function(ListedSecurityName?)>[];
  Timer? timer;
  bool readyToSend = false;
  List<ListedSecurityName> items = [];
  int waitingTime = 1;


  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTextTheme = Theme.of(context).textTheme;

    if (widget.required ?? false) {
      validators.add(FormBuilderValidators.required(
          errorText: widget.errorMsg ??
              (widget.title != null
                  ? 'Please enter ${widget.title!.toLowerCase()}'
                  : appLocalizations.common_errors_required)));
    }

    return FormBuilderField<ListedSecurityName?>(
      builder: (state) {
        if (typeController.text.isEmpty) {
          if (state.value != null) {
            typeController.text = state.value!.securityName ?? "";
          }
        }
        return BlocProvider(
          create: (context) => sl<BankListCubit>(),
          child: Builder(
            builder: (context) {
              return BlocConsumer<BankListCubit, BankListState>(
                listener: (context, bankState) {
                  if (bankState is MarketDataSuccess) {
                      items = bankState.entity;
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
                            if(p0.length<3){
                              return [];
                            }else{
                              await Future.delayed(Duration(seconds: waitingTime,milliseconds: 100));
                              if(readyToSend){
                                // ignore: use_build_context_synchronously
                                await context.read<BankListCubit>().getMarketData(p0);
                                await Future.delayed(const Duration(milliseconds: 200));
                              }
                              return items;
                            }

                          },
                          loadingBuilder: (context) => const LoadingWidget(),
                          itemBuilder: (context, suggestion) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(suggestion.securityName)),
                                        const SizedBox(width: 24),
                                        Expanded(
                                            child: Text(
                                                suggestion.currencyCode ?? "")),
                                        Expanded(child: Text(suggestion.category)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(suggestion.securityShortName,
                                            style: appTextTheme.bodySmall),
                                        const Text(" . "),
                                        Text(suggestion.tradedExchange,
                                            style: appTextTheme.bodySmall),
                                      ],
                                    ),
                                    Text(suggestion.isin,
                                        style: appTextTheme.bodySmall)
                                  ]),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            typeController.text = suggestion.securityName;
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
