import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/extentions/app_form_validators.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class CurrencyInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    double value = double.tryParse(newValue.text.replaceAll(",", "")) ?? 0;

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
}

class AppTextFields {
  AppTextFields._();

  static FormBuilderTextField simpleTextField({
    required String name,
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
    List<String? Function(String?)>? extraValidators,
    onChanged,
  }) {
    final validators = <String? Function(String?)>[];
    if(extraValidators != null){
      validators.addAll(extraValidators);
    }
    if (required) {
      validators.add(FormBuilderValidators.required());
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
    }
    return FormBuilderTextField(
      key: key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: type == TextFieldType.money ? [
      CurrencyInputFormatter()
      ] : null,
      scrollPadding:
          const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 90),
      name: name,
      minLines: minLines ?? 1,
      maxLines: (type == TextFieldType.password) ? 1 : 5,
      enabled: enabled,
      decoration: InputDecoration(
          labelText: title, hintText: hint, suffixIcon: suffixIcon),
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

class CurrenciesDropdown extends StatelessWidget {
  const CurrenciesDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderSearchableDropdown<Currency>(
      name: "currencyCode",
      hint: "Type or select currency",
      items: Currency.currenciesList,
      itemAsString: (Currency currency) =>
          "${currency.name} (${currency.symbol})",
      filterFn: (currency, string) {
        return (currency.name.toLowerCase().contains(string.toLowerCase()) ||
            currency.symbol.toLowerCase().contains(string.toLowerCase()));
      },
      itemBuilder: (context, currency, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${currency.name} (${currency.symbol})"),
        );
      },
    );
  }
}

class CountriesDropdown extends StatelessWidget {
  const CountriesDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderSearchableDropdown<Country>(
      name: "country",
      hint: "Type or select a country",
      items: Country.countriesList,
      itemAsString: (country) => "${country.name} (${country.countryName})",
      filterFn: (country, string) {
        return (country.name.toLowerCase().contains(string.toLowerCase()) ||
            country.countryName.toLowerCase().contains(string.toLowerCase()));
      },
      itemBuilder: (context, country, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${country.name} (${country.countryName})"),
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

  const FormBuilderSearchableDropdown(
      {Key? key,
      required this.name,
      required this.hint,
      this.itemAsString,
      this.filterFn,
      this.itemBuilder,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
  const FormBuilderTypeAhead(
      {Key? key, required this.name, required this.items, required this.hint})
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
        name: widget.name);
  }
}

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  final String? hint;
  final GlobalKey<FormBuilderFieldState>? passwordKey;
  Function? onChange;

  PasswordTextField({Key? key, this.hint, this.onChange, this.passwordKey})
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
            name: "password",
            type: TextFieldType.password,
            hint: widget.hint ??
                appLocalizations.auth_signup_input_password_placeholder,
            obscureText: !visible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
              icon: Icon(
                visible ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onChanged: widget.onChange),
      ],
    );
  }
}
