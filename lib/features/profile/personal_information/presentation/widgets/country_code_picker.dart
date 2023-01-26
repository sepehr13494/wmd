import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<Country?>? onChange;
  const CountryCodePicker({Key? key, required this.onChange}) : super(key: key);

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {

  TextEditingController controller = TextEditingController();
  final Country? defaultCountry = Country.tryParse("bahrain");

  @override
  void initState() {
    if(defaultCountry != null){
      controller.text = "${defaultCountry!.flagEmoji} +${defaultCountry!.phoneCode}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<Country>(builder: ((field) {
      if(field.value!=null){
        controller.text = "${field.value!.flagEmoji} +${field.value!.phoneCode}";
      }
      return SizedBox(
        width: 100,
        child: TextField(
          controller: controller,
          readOnly: true,
          onTap: (){
            showCountryPicker(
              context: context,
              showPhoneCode: true, // optional. Shows phone code before the country name.
              onSelect: (Country country) {
                print('Select country: ${country.displayName}');
                controller.text = "${country.flagEmoji} +${country.phoneCode}";
                field.didChange(country);
              },
            );
          },
        ),
      );
    }), name: "country",initialValue: defaultCountry,onChanged: widget.onChange,);
  }
}
