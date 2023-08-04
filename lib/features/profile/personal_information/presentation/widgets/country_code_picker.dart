import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<Country?>? onChange;
  final bool enabled;
  const CountryCodePicker(
      {Key? key, required this.onChange, this.enabled = true})
      : super(key: key);

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  TextEditingController controller = TextEditingController();
  final Country? defaultCountry = Country.tryParse("bahrain");

  @override
  void initState() {
    if (defaultCountry != null) {
      controller.text =
          "${defaultCountry!.flagEmoji} +${defaultCountry!.phoneCode}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isTablet = !responsiveHelper.isMobile;

    return FormBuilderField<Country>(
      builder: ((field) {
        if (field.value != null) {
          controller.text =
              "${field.value!.flagEmoji} ${field.value!.countryCode} +${field.value!.phoneCode}";
        }
        return SizedBox(
          width: isTablet ? 100 : 116,
          // height: 80,
          child: TextField(
            controller: controller,
            style: Theme.of(context).textTheme.bodySmall,
            readOnly: true,
            enabled: widget.enabled,
            onTap: () {
              showCountryPicker(
                context: context,

                showPhoneCode:
                    true, // optional. Shows phone code before the country name.
                onSelect: (Country country) {
                  log('Select country: ${country.displayName}');

                  String code = country.phoneCode;

                  if (code == "44") {
                    switch (country.countryCode) {
                      case "GG":
                        code = "441481";
                        break;
                      case "IM":
                        code = "441624";
                        break;
                      case "JE":
                        code = "441534";
                        break;
                    }
                  }

                  controller.text =
                      "${country.flagEmoji} ${country.countryCode} +$code";
                  field.didChange(Country.from(
                      json: {...country.toJson(), "e164_cc": code}));
                },
              );
            },
          ),
        );
      }),
      name: "country",
      initialValue: controller.text == "" ? defaultCountry : null,
      onChanged: widget.onChange,
    );
  }
}
