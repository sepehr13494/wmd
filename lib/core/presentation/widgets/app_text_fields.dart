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

enum TextFieldType { email, password, phone, simpleText, money, number, rate }

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AppTextFields {
  AppTextFields._();

  static FormBuilderTextField simpleTextField({
    required String name,
    bool showTitle = false,
    TextFieldType type = TextFieldType.simpleText,
    GlobalKey<FormBuilderFieldState>? key,
    String? title,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int? minLines,
    bool enabled = true,
    bool obscureText = false,
    Widget? suffixIcon,
    bool required = true,
    bool readOnly = false,
    List<String? Function(String?)>? extraValidators,
    ValueChanged<String?>? onChanged,
  }) {
    final validators = <String? Function(String?)>[];
    if (extraValidators != null) {
      validators.addAll(extraValidators);
    }
    if (required) {
      validators.add(FormBuilderValidators.required(
          errorText:
              title != null ? 'Please enter ${title.toLowerCase()}' : null));
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
    }
    return FormBuilderTextField(
      key: key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: type == TextFieldType.money
          ? [CurrencyInputFormatter()]
          : type == TextFieldType.number
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : type == TextFieldType.rate
                  ? [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ]
                  : null,
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
          suffixIcon: suffixIcon),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      autofillHints:
          _getAutofillHint(type) == null ? null : [_getAutofillHint(type)!],
      validator: FormBuilderValidators.compose(validators),
      onChanged: onChanged,
    );
  }

  static String? _getAutofillHint(TextFieldType type) {
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
    }
  }

  static FormBuilderDropdown dropDownTextField({
    required final String name,
    required final String hint,
    final ValueChanged? onChanged,
    required final List<DropdownMenuItem> items,
    bool enabled = true,
  }) {
    return FormBuilderDropdown(
      name: name,
      enabled: enabled,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hint,
      ),
      items: items,
      validator: FormBuilderValidators.required(),
    );
  }
}

class CurrenciesDropdown extends StatefulWidget {
  final ValueChanged<Currency?>? onChanged;
  final bool showExchange;
  const CurrenciesDropdown(
      {Key? key, this.onChanged, this.showExchange = false})
      : super(key: key);

  @override
  State<CurrenciesDropdown> createState() => _CurrenciesDropdownState();
}

class _CurrenciesDropdownState extends State<CurrenciesDropdown> {
  Currency? selectedCurrency =
      Currency(symbol: "USD", name: "United States dollar");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderSearchableDropdown<Currency>(
          name: "currencyCode",
          hint: "Type or select currency",
          items: Currency.currenciesList,
          onChanged: (val) {
            // setState
            if (widget.onChanged != null) {
              widget.onChanged!(val);
            }
            setState(() {
              selectedCurrency = val;
            });
          },
          itemAsString: (Currency currency) =>
              "${currency.name} (${currency.symbol})",
          filterFn: (currency, string) {
            return (currency.name
                    .toLowerCase()
                    .contains(string.toLowerCase()) ||
                currency.symbol.toLowerCase().contains(string.toLowerCase()));
          },
          itemBuilder: (context, currency, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${currency.name} (${currency.symbol})"),
            );
          },
        ),
        if (widget.showExchange) ...[
          const SizedBox(
            height: 10,
          ),
          Text('1 USD = 1.5 ${selectedCurrency?.symbol}'),
          Text(
              'Exchange rate for ${DateFormat('d MMM, yyyy').format(DateTime.now()).toString()}')
        ]
      ],
    );
  }
}

class CountriesDropdown extends StatelessWidget {
  final ValueChanged<Country?>? onChanged;
  const CountriesDropdown({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderSearchableDropdown<Country>(
      name: "country",
      hint: "Type or select a country",
      items: Country.countriesList,
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

class FormBuilderSearchableDropdown<T> extends StatelessWidget {
  final String name;
  final String hint;
  final DropdownSearchItemAsString<T>? itemAsString;
  final DropdownSearchFilterFn<T>? filterFn;
  final DropdownSearchPopupItemBuilder<T>? itemBuilder;
  final List<T> items;
  final ValueChanged<T?>? onChanged;

  const FormBuilderSearchableDropdown(
      {Key? key,
      required this.name,
      required this.hint,
      this.itemAsString,
      this.filterFn,
      this.itemBuilder,
      required this.items,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        builder: (FormFieldState field) {
          return DropdownSearch<T>(
            itemAsString: itemAsString,
            filterFn: filterFn,
            popupProps:
                PopupProps.menu(showSearchBox: true, itemBuilder: itemBuilder),
            items: items,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: hint,
              ),
            ),
            onChanged: (value) => field.didChange(value),
            selectedItem: field.value,
          );
        },
        name: name);
  }
}

class FormBuilderTypeAhead extends StatefulWidget {
  final String name;
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChange;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const FormBuilderTypeAhead(
      {Key? key,
      required this.name,
      required this.items,
      required this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.onChange})
      : super(key: key);

  @override
  State<FormBuilderTypeAhead> createState() => _FormBuilderTypeAheadState();
}

class _FormBuilderTypeAheadState extends State<FormBuilderTypeAhead> {
  TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String?>(
        builder: (state) {
          return TypeAheadField(
            animationStart: 0,
            animationDuration: Duration.zero,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                hintText: widget.hint,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
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
          );
        },
        onChanged: widget.onChange,
        name: widget.name);
  }
}

class ListedSecurityTypeAhead extends StatefulWidget {
  final String name;
  final String hint;
  final List<ListedSecurityName> items;
  final ValueChanged<ListedSecurityName?>? onChange;

  const ListedSecurityTypeAhead(
      {Key? key,
      required this.name,
      required this.items,
      required this.hint,
      this.onChange})
      : super(key: key);

  @override
  State<ListedSecurityTypeAhead> createState() =>
      _ListedSecurityTypeAheadState();
}

class _ListedSecurityTypeAheadState extends State<ListedSecurityTypeAhead> {
  TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;

    return FormBuilderField<ListedSecurityName?>(
        builder: (state) {
          return TypeAheadField(
            animationStart: 0,
            animationDuration: Duration.zero,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                hintText: widget.hint,
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
          );
        },
        onChanged: widget.onChange,
        name: widget.name);
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
  ValueChanged<String?>? onChange;

  PasswordTextField(
      {Key? key,
      this.hint,
      this.onChange,
      this.passwordKey,
      this.name,
      this.showEye = true})
      : super(key: key);

  @override
  AppState<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends AppState<PasswordTextField> {
  bool visible = false;

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
            hint: widget.name ??
                (widget.hint ??
                    appLocalizations.auth_signup_input_password_placeholder),
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
  final ValueChanged<String?>? onChange;

  const RadioButton({
    Key? key,
    this.hint,
    this.onChange,
    this.initialValue,
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
    return SizedBox(
      child: Row(children: [
        Expanded(
            child: FormBuilderRadioGroup(
                onChanged: (value) {
                  // String paymentMethod = value.toString();
                  // paymentViewModel.setPaymentMethod(paymentMethod);

                  print(value.toString());
                },
                initialValue: widget.initialValue,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                ),
                orientation: OptionsOrientation.horizontal,
                name: widget.name,
                activeColor: Theme.of(context).primaryColor,
                options: widget.items
                    .map((option) => FormBuilderFieldOption(
                          value: option.value,
                          child: Text(option.label),
                        ))
                    .toList(growable: false))),
      ]

          // widget.items
          //     .map((e) => Expanded(
          //             child: ListTile(
          //           title: Text(e.label, style: textTheme.bodySmall),
          //           leading: Radio<T>(
          //             value: e.value,
          //             groupValue: e.value,
          //             activeColor: Theme.of(context).primaryColor,
          //             onChanged: (value) {
          //               // setState(() {
          //               //   _character = value;
          //               // });
          //             },
          //           ),
          //         )))
          //     .toList()

          ),
    );

    // ListTile(
    //         title: Text(e.label),
    //         leading: Radio<T>(
    //           value: e.value,
    //           groupValue: e.value,
    //           onChanged: (value) {
    //             // setState(() {
    //             //   _character = value;
    //             // });
    //           },
    //         ),
    //       )

    // ListView.builder(
    //     itemCount: widget.items.length,
    //     itemBuilder: (BuildContext bctx, int index) {
    //       return ListTile(
    //         title: Text(widget.items[index].label),
    //         leading: Radio<T>(
    //           value: widget.items[index].value,
    //           groupValue: widget.items[index].value,
    //           onChanged: (value) {
    //             // setState(() {
    //             //   _character = value;
    //             // });
    //           },
    //         ),
    //       );
    //     });

    // Column(
    //   children:

    //   <Widget>[
    //     ListTile(
    //       title: const Text('Lafayette'),
    //       leading: Radio<String>(
    //         value: SingingCharacter.lafayette,
    //         groupValue: _character,
    //         onChanged: (SingingCharacter? value) {
    //           setState(() {
    //             _character = value;
    //           });
    //         },
    //       ),
    //     ),
    //     ListTile(
    //       title: const Text('Thomas Jefferson'),
    //       leading: Radio<SingingCharacter>(
    //         value: SingingCharacter.jefferson,
    //         groupValue: _character,
    //         onChanged: (SingingCharacter? value) {
    //           setState(() {
    //             _character = value;
    //           });
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
