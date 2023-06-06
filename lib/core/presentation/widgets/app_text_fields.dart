// ignore_for_file: unnecessary_new

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/models/radio_button_options.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.tryParse(newValue.text.replaceAll(",", "")) ?? 0;

    String newText = NumberFormat("#,##0", "en_US").format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class CurrencyWithNegetiveInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    debugPrint(newValue.text);
    debugPrint("newValue.text");

    double value = 0;

    if (newValue.text == "-") {
      return newValue;
    } else {
      value = double.tryParse(newValue.text.replaceAll(",", "")) ?? 0;
    }

    debugPrint(value.toString());

    String newText = NumberFormat("#,##0", "en_US").format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

enum TextFieldType {
  email,
  password,
  phone,
  simpleText,
  money,
  minusMoney,
  number,
  rate
}

class AppTextFields {
  AppTextFields._();

  static FormBuilderDropdown dropDownTextField({
    final String errorMsg = "",
    required final String name,
    required final String hint,
    final double fontSize = 15,
    final ValueChanged? onChanged,
    final ValueChanged? selectedItemBuilder,
    final dynamic initial,
    required final List<DropdownMenuItem> items,
    bool enabled = true,
  }) {
    return FormBuilderDropdown(
      name: name,
      enabled: enabled,
      onChanged: onChanged,
      initialValue: initial,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hint,
      ),
      style: TextStyle(fontSize: fontSize),
      dropdownColor: AppColors.backgroundColorPageDark,
      items: items,
      validator: FormBuilderValidators.required(
          errorText: errorMsg != "" ? errorMsg : null),
    );
  }

  static Widget rateSuffixIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.16),
        borderRadius: BorderRadius.horizontal(
            left: Radius.zero, right: Radius.circular(4)),
      ),
      child: const Icon(
        Icons.percent,
        color: Color.fromRGBO(170, 170, 170, 1),
      ),
    );
  }

  static Widget simpleTextField({
    required String name,
    bool showTitle = false,
    TextFieldType type = TextFieldType.simpleText,
    GlobalKey<FormBuilderFieldState>? key,
    String? title,
    String? errorMsg,
    String? hint,
    int? errorMaxLines,
    TextInputType keyboardType = TextInputType.text,
    int? minLines,
    bool enabled = true,
    bool obscureText = false,
    Widget? suffixIcon,
    bool required = true,
    bool readOnly = false,
    List<String? Function(String?)>? extraValidators,
    List<TextInputFormatter>? customInputFormatters,
    ValueChanged<String?>? onChanged,
  }) {
    return SimpleTextField(
      name: name,
      showTitle: showTitle,
      type: type,
      formKey: key,
      title: title,
      errorMsg: errorMsg,
      hint: hint,
      keyboardType: keyboardType,
      minLines: minLines,
      enabled: enabled,
      // errorMaxLines: errorMaxLines,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      required: required,
      readOnly: readOnly,
      customInputFormatters: customInputFormatters,
      extraValidators: extraValidators,
      onChanged: onChanged,
    );
  }
}

class SimpleTextField extends AppStatelessWidget {
  final String name;
  final bool showTitle;
  final TextFieldType type;
  final GlobalKey<FormBuilderFieldState>? formKey;
  final String? title;
  final String? errorMsg;
  final String? hint;
  final TextInputType keyboardType;
  final int? minLines;
  final bool enabled;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool required;
  final bool readOnly;
  final List<TextInputFormatter>? customInputFormatters;
  final List<String? Function(String?)>? extraValidators;
  final ValueChanged<String?>? onChanged;

  const SimpleTextField({
    Key? key,
    required this.name,
    required this.showTitle,
    required this.type,
    this.formKey,
    this.title,
    this.errorMsg,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.minLines,
    this.enabled = true,
    this.obscureText = false,
    this.suffixIcon,
    this.customInputFormatters,
    this.required = true,
    this.readOnly = false,
    this.extraValidators,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final validators = <String? Function(String?)>[];
    if (extraValidators != null) {
      validators.addAll(extraValidators!);
    }
    if (required) {
      validators.add(FormBuilderValidators.required(
          errorText: errorMsg ??
              (title != null
                  ? 'Please enter ${title!.toLowerCase()}'
                  : appLocalizations.common_errors_required)));
    }
    if (type == TextFieldType.money) {
      validators.add((val) {
        return (val != null &&
                (double.tryParse(val.replaceAll(",", "")) ?? 0) > 1000000000)
            ? "Amount should be less than 1,000,000,000"
            : null;
      });
    }
    switch (type) {
      case TextFieldType.email:
        validators.add(FormBuilderValidators.email());
        break;
      case TextFieldType.password:
        // validators.add(FormBuilderValidators.minLength(8));
        // validators.add(AppFormValidators.validatePassword());
        break;
      case TextFieldType.phone:
        break;
      case TextFieldType.simpleText:
        break;
      case TextFieldType.money:
        break;
      case TextFieldType.number:
        break;
      case TextFieldType.rate:
        break;
      case TextFieldType.minusMoney:
        break;
    }
    return FormBuilderTextField(
      key: key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: customInputFormatters ??
          (type == TextFieldType.money
              ? [CurrencyInputFormatter()]
              : type == TextFieldType.minusMoney
                  ? [CurrencyWithNegetiveInputFormatter()]
                  : type == TextFieldType.number
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]
                      : type == TextFieldType.rate
                          ? [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,3}'))
                            ]
                          : null),
      scrollPadding:
          const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 90),
      name: name,
      readOnly: readOnly,
      minLines: minLines ?? 1,
      maxLines: (type == TextFieldType.password) ? 1 : 5,
      enabled: enabled,
      decoration: InputDecoration(
          labelText: showTitle ? title : null,
          hintText: hint,
          errorMaxLines: 2,
          suffixIcon: suffixIcon),
      style:
          TextStyle(color: !enabled ? Theme.of(context).disabledColor : null),
      obscureText: obscureText,
      keyboardType:
          type == TextFieldType.number ? TextInputType.number : keyboardType,
      textInputAction: TextInputAction.next,
      autofillHints:
          _getAutofillHint(type) == null ? null : [_getAutofillHint(type)!],
      validator: FormBuilderValidators.compose(validators),
      onChanged: onChanged,
    );
  }

  String? _getAutofillHint(TextFieldType type) {
    switch (type) {
      case TextFieldType.email:
        return AutofillHints.email;
      case TextFieldType.password:
        return AutofillHints.password;
      case TextFieldType.phone:
        return AutofillHints.telephoneNumber;
      case TextFieldType.simpleText:
        return null;
      case TextFieldType.money:
        return null;
      case TextFieldType.number:
        return null;
      case TextFieldType.rate:
        return null;
      case TextFieldType.minusMoney:
        return null;
    }
  }
}

class CurrenciesDropdown extends StatefulWidget {
  final ValueChanged<Currency?>? onChanged;
  final bool enabled;

  const CurrenciesDropdown({Key? key, this.onChanged, this.enabled = false})
      : super(key: key);

  @override
  AppState<CurrenciesDropdown> createState() => _CurrenciesDropdownState();
}

class _CurrenciesDropdownState extends AppState<CurrenciesDropdown> {
  Currency? selectedCurrency =
      Currency(symbol: "USD", name: "United States dollar");

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderSearchableDropdown<Currency>(
          name: "currencyCode",
          hint: appLocalization
              .assetLiabilityForms_forms_bankAccount_inputFields_country_placeholder,
          items: Currency.currenciesList,
          enabled: widget.enabled,
          prefixIcon: const Icon(
            Icons.search,
          ),
          onChanged: (val) {
            // setState
            if (widget.onChanged != null) {
              widget.onChanged!(val);
            }
            setState(() {
              selectedCurrency = val;
            });
          },
          itemAsString: (Currency currency) => currency.name,
          filterFn: (currency, string) {
            return (currency.name
                    .toLowerCase()
                    .contains(string.toLowerCase()) ||
                currency.symbol.toLowerCase().contains(string.toLowerCase()));
          },
          itemBuilder: (context, currency, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currency.name,
              ),
            );
          },
        ),
        if (AppConstants.currencyConvertor && !AppConstants.isRelease1) ...[
          const SizedBox(
            height: 10,
          ),
          Text('1 USD = 1 ${selectedCurrency?.symbol}'),
          Text(
              'Exchange rate for ${DateFormat('d MMM, yyyy').format(DateTime.now()).toString()}')
        ]
      ],
    );
  }
}

class CountriesDropdown extends AppStatelessWidget {
  final ValueChanged<Country?>? onChanged;

  const CountriesDropdown({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return FormBuilderSearchableDropdown<Country>(
      name: "country",
      hint: appLocalizations
          .assetLiabilityForms_forms_bankAccount_inputFields_country_placeholder,
      prefixIcon: const Icon(
        Icons.search,
      ),
      errorMsg: appLocalizations
          .assetLiabilityForms_forms_realEstate_inputFields_country_errorMessage,
      items: Country.getCountryList(),
      onChanged: onChanged,
      itemAsString: (country) => country.countryName,
      filterFn: (country, string) {
        return (country.name.toLowerCase().contains(string.toLowerCase()) ||
            country.countryName.toLowerCase().contains(string.toLowerCase()));
      },
      itemBuilder: (context, country, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(country.countryName),
        );
      },
    );
  }
}

class FormBuilderSearchableDropdown<T> extends AppStatelessWidget {
  final String name;
  final String? title;
  final String? errorMsg;
  final String hint;
  final DropdownSearchItemAsString<T>? itemAsString;
  final DropdownSearchFilterFn<T>? filterFn;
  final DropdownSearchPopupItemBuilder<T>? itemBuilder;
  final List<T> items;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final bool required;
  final bool enabled;
  final Widget? prefixIcon;
  final bool showSearchBox;
  final List<String? Function(T?)>? extraValidators;

  const FormBuilderSearchableDropdown(
      {Key? key,
      required this.name,
      required this.hint,
      this.itemAsString,
      this.filterFn,
      this.title,
      this.initialValue,
      this.errorMsg,
      this.itemBuilder,
      this.extraValidators,
      this.required = true,
      this.enabled = true,
      this.showSearchBox = true,
      required this.items,
      this.prefixIcon,
      this.onChanged})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final validators = <String? Function(T?)>[];
    if (extraValidators != null) {
      validators.addAll(extraValidators!);
    }
    if (required) {
      validators.add(FormBuilderValidators.required(
          errorText: errorMsg ??
              (title != null
                  ? 'Please enter ${title!.toLowerCase()}'
                  : appLocalizations.common_errors_required)));
    }

    return FormBuilderField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose(validators),
        onChanged: onChanged,
        initialValue: initialValue,
        enabled: enabled,
        builder: (FormFieldState field) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownSearch<T>(
                  itemAsString: itemAsString,
                  filterFn: filterFn,
                  enabled: enabled,
                  popupProps: PopupProps.menu(
                      menuProps: const MenuProps(
                          backgroundColor: AppColors.backgroundColorPageDark),
                      showSearchBox: showSearchBox,
                      fit: FlexFit.loose,
                      itemBuilder: itemBuilder,
                      searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(prefixIcon: prefixIcon))),
                  items: items,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: TextStyle(
                        color: enabled ? Colors.white : Colors.grey[700]),
                    dropdownSearchDecoration: InputDecoration(
                      hintText: hint,
                      disabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey[800]!,
                          )),
                      // prefixIcon: prefixIcon,
                      enabledBorder: field.hasError
                          ? const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.red,
                              ))
                          : null,
                    ),
                  ),
                  onChanged: (value) => field.didChange(value),
                  selectedItem: field.value,
                ),
                if (field.hasError) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                    child: Text(
                      field.errorText ?? "",
                      style: TextStyle(fontSize: 12, color: Colors.red[600]),
                    ),
                  ),
                ]
              ]);
        },
        name: name);
  }
}

class FormBuilderTypeAhead extends StatefulWidget {
  final String? title;
  final String name;
  final String hint;
  final String? errorMsg;
  final List<String> items;
  final ValueChanged<String?>? onChange;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? required;
  final List<String? Function(String?)>? extraValidators;
  final bool enabled;

  const FormBuilderTypeAhead({
    Key? key,
    required this.name,
    required this.items,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.title,
    this.errorMsg,
    this.extraValidators,
    this.required = true,
    this.onChange,
    this.enabled = true,
  }) : super(key: key);

  @override
  AppState<FormBuilderTypeAhead> createState() => _FormBuilderTypeAheadState();
}

class _FormBuilderTypeAheadState extends AppState<FormBuilderTypeAhead> {
  TextEditingController typeController = TextEditingController();
  final validators = <String? Function(String?)>[];

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    if (widget.extraValidators != null) {
      validators.addAll(widget.extraValidators!);
    }
    if (widget.required ?? false) {
      validators.add(FormBuilderValidators.required(
          errorText: widget.errorMsg ??
              (widget.title != null
                  ? 'Please enter ${widget.title!.toLowerCase()}'
                  : appLocalizations.common_errors_required)));
    }

    return FormBuilderField<String?>(
      builder: (state) {
        if (typeController.text.isEmpty) {
          typeController.text = state.value ?? "";
        }
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TypeAheadField(
            animationStart: 0,
            animationDuration: Duration.zero,
            textFieldConfiguration: TextFieldConfiguration(
              enabled: widget.enabled,
              style: TextStyle(color: widget.enabled ? null : Theme.of(context).disabledColor),
              decoration: InputDecoration(
                hintText: widget.hint,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                disabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).disabledColor,
                    )),
                enabledBorder: state.hasError
                    ? const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.red,
                    ))
                    : OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    width: 1,
                    color: widget.enabled ? Theme.of(context).textTheme.titleMedium!.color! : Theme.of(context).disabledColor,
                  ),
                ),
              ),
              controller: typeController,
              onChanged: (value) {
                state.didChange(value);
              },
            ),
            suggestionsCallback: (pattern) {
              return widget.items.where((element) =>
                  element.toLowerCase().contains(pattern.toLowerCase()));
            },
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
            hideOnEmpty: true,
          ),
          if (state.hasError) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
              child: Text(
                state.errorText ?? "",
                style: TextStyle(fontSize: 12, color: Colors.red[600]),
              ),
            ),
          ]
        ]);
      },
      onChanged: widget.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(validators),
      name: widget.name,
    );
  }
}

class ListedSecurityTypeAhead extends StatefulWidget {
  final String name;
  final String? title;
  final String hint;
  final String? errorMsg;
  final List<ListedSecurityName> items;
  final ValueChanged<ListedSecurityName?>? onChange;
  final bool? required;
  final List<String? Function(String?)>? extraValidators;
  final bool enabled;

  const ListedSecurityTypeAhead({
    Key? key,
    required this.name,
    required this.items,
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
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TypeAheadField(
            animationStart: 0,
            animationDuration: Duration.zero,
            textFieldConfiguration: TextFieldConfiguration(
              style: TextStyle(color: widget.enabled ? null : Theme.of(context).disabledColor),
              enabled: widget.enabled,
              decoration: InputDecoration(
                hintText: widget.hint,
                enabledBorder: state.hasError
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.red,
                        ))
                    : OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.enabled ? Theme.of(context).textTheme.titleMedium!.color! : Theme.of(context).disabledColor,
                    ),
                ),
              ),
              controller: typeController,
              onChanged: (value) {
                final currentValue = widget.items
                    .firstWhere((element) => element.securityName == value);
                state.didChange(currentValue);
              },
            ),
            suggestionsCallback: (pattern) {
              return widget.items.where((element) =>
                  element.securityName
                      .toLowerCase()
                      .contains(pattern.toLowerCase()) ||
                  element.securityShortName
                      .toLowerCase()
                      .contains(pattern.toLowerCase()) ||
                  element.isin.toLowerCase().contains(pattern.toLowerCase()));
            },
            itemBuilder: (context, suggestion) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(suggestion.securityName)),
                          const SizedBox(width: 24),
                          Expanded(child: Text(suggestion.currencyCode ?? "")),
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
                      Text(suggestion.isin, style: appTextTheme.bodySmall)
                    ]),
              );
            },
            onSuggestionSelected: (suggestion) {
              typeController.text = suggestion.securityName;
              state.didChange(suggestion);
            },
            hideOnEmpty: true,
          ),
          if (state.hasError) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
              child: Text(
                state.errorText ?? "",
                style: TextStyle(fontSize: 12, color: Colors.red[600]),
              ),
            ),
          ]
        ]);
      },
      onChanged: widget.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(validators),
      name: widget.name,
    );
  }
}

class DropDownTypeAhead extends StatefulWidget {
  final String name;
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChange;

  const DropDownTypeAhead(
      {Key? key,
      required this.name,
      required this.items,
      required this.hint,
      this.onChange})
      : super(key: key);

  @override
  State<DropDownTypeAhead> createState() => _DropDownTypeAheadState();
}

class _DropDownTypeAheadState extends State<DropDownTypeAhead> {
  TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String?>(
        builder: (state) {
          return Stack(
            children: [
              Positioned(
                right: 0,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_drop_down)),
              ),
              TypeAheadField(
                animationStart: 0,
                animationDuration: Duration.zero,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintText: widget.hint,
                  ),
                  controller: typeController,
                  onChanged: (value) {
                    state.didChange(value);
                  },
                ),
                suggestionsCallback: (pattern) {
                  return widget.items.where((element) =>
                      element.toLowerCase().contains(pattern.toLowerCase()));
                },
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
                hideOnEmpty: true,
              ),
            ],
          );
        },
        onChanged: widget.onChange,
        name: widget.name);
  }
}

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  final String? hint;
  final String? name;
  final bool showEye;
  final GlobalKey<FormBuilderFieldState>? passwordKey;
  final List<String? Function(String?)>? extraValidators;
  ValueChanged<String?>? onChange;

  PasswordTextField(
      {Key? key,
      this.hint,
      this.onChange,
      this.passwordKey,
      this.extraValidators,
      this.name,
      this.showEye = true})
      : super(key: key);

  @override
  AppState<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends AppState<PasswordTextField> {
  bool visible = false;
  final validators = <String? Function(String?)>[];

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFields.simpleTextField(
            key: widget.passwordKey,
            name: widget.name ?? "password",
            type: TextFieldType.password,
            hint: widget.hint ??
                appLocalizations.auth_signup_input_password_placeholder,
            obscureText: !visible,
            suffixIcon: widget.showEye
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    icon: Icon(
                      visible
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : null,
            extraValidators: widget.extraValidators,
            onChanged: widget.onChange),
      ],
    );
  }
}

class RadioButton<T> extends StatefulWidget {
  final String? hint;
  final List<RadioButtonOptions<T>> items;
  final String? initialValue;
  final String name;
  final String? errorMsg;
  final bool required;
  final ValueChanged<String?>? onChange;

  const RadioButton({
    Key? key,
    this.hint,
    this.onChange,
    this.initialValue,
    this.errorMsg,
    this.required = true,
    required this.items,
    required this.name,
  }) : super(key: key);

  @override
  AppState<RadioButton> createState() => _RadioButtontate<T>();
}

class _RadioButtontate<T> extends AppState<RadioButton> {
  bool visible = false;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final validators = <String? Function(dynamic?)>[];

    if (widget.required) {
      validators.add(FormBuilderValidators.required(
          errorText:
              widget.errorMsg ?? appLocalizations.common_errors_required));
    }

    return SizedBox(
      child: Row(children: [
        Expanded(
            child: FormBuilderRadioGroup(
                onChanged: (value) {
                  // String paymentMethod = value.toString();
                  // paymentViewModel.setPaymentMethod(paymentMethod);

                  debugPrint(value.toString());
                },
                initialValue: widget.initialValue,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose(validators),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                ),
                orientation: OptionsOrientation.horizontal,
                name: widget.name,
                activeColor: Theme.of(context).primaryColor,
                hoverColor: Theme.of(context).primaryColor,
                options: widget.items
                    .map((option) => FormBuilderFieldOption(
                          value: option.value,
                          child: Text(option.label),
                        ))
                    .toList(growable: false))),
      ]),
    );
  }
}

class TimeslotsSelector<T> extends AppStatelessWidget {
  final String name;
  final bool? isToday;
  final ValueChanged<T?>? onChanged;

  const TimeslotsSelector(
      {Key? key, required this.name, this.onChanged, this.isToday = false})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return FormBuilderField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        builder: (FormFieldState field) {
          return Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["9.00 - 10.00", "", "11.00 - 12.00"]
                      .map((time) => time == ""
                          ? const SizedBox(
                              width: 15,
                            )
                          : Expanded(
                              child: OutlinedButton(
                              onPressed: int.parse(DateFormat('HH')
                                              .format(DateTime.now())) >=
                                          int.parse(time.split(".")[0]) &&
                                      isToday!
                                  ? null
                                  : () {
                                      field.didChange(time);
                                    },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                  ),
                                  side: field.value != time
                                      ? MaterialStateProperty.all(
                                          const BorderSide(
                                          color: Colors.transparent,
                                        ))
                                      : null,
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color!
                                          .withOpacity(0.07))),
                              child: Text(time),
                            )))
                      .toList()),
              const SizedBox(
                height: 15,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ["13.00 - 14.00", "", "15.00 - 16.00"]
                      .map((time) => time == ""
                          ? const SizedBox(
                              width: 15,
                            )
                          : Expanded(
                              child: OutlinedButton(
                              onPressed: int.parse(DateFormat('HH')
                                              .format(DateTime.now())) >=
                                          int.parse(time.split(".")[0]) &&
                                      isToday!
                                  ? null
                                  : () {
                                      field.didChange(time);
                                    },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                  ),
                                  side: field.value != time
                                      ? MaterialStateProperty.all(
                                          const BorderSide(
                                          color: Colors.transparent,
                                        ))
                                      : null,
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(220, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color!
                                          .withOpacity(0.07))),
                              child: Text(time),
                            )))
                      .toList()),
              if (field.hasError)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                  child: Text(
                    appLocalizations.common_errors_required,
                    style: TextStyle(fontSize: 12, color: Colors.red[600]),
                  ),
                ),
            ],
          );

          // DropdownSearch<T>(
          //   itemAsString: itemAsString,
          //   filterFn: filterFn,
          //   popupProps:
          //       PopupProps.menu(showSearchBox: true, itemBuilder: itemBuilder),
          //   items: items,
          //   dropdownDecoratorProps: DropDownDecoratorProps(
          //     dropdownSearchDecoration: InputDecoration(
          //       hintText: hint,
          //     ),
          //   ),
          //   onChanged: (value) => field.didChange(value),
          //   selectedItem: field.value,
          // );
        },
        name: name);
  }
}
