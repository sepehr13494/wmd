import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/search_text_field.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/data_sources/countries.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/data_sources/currencies.dart';

class AddBankManualPage extends AppStatelessWidget {
  const AddBankManualPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Asset"),
      ),
      body: Stack(
        children: [
          const LeafBackground(),
          WidthLimiterWidget(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      "Add bank account",
                      style: textTheme.headlineSmall,
                    ),
                    Text(
                      "Fill in your cash details",
                      style: textTheme.titleMedium,
                    ),
                    EachTextField(
                      hasInfo: false,
                      title: "Bank Name",
                      child: AppTextFields.simpleTextField(
                          name: "bankName", hint: "Your bank name"),
                    ),
                    EachTextField(
                      hasInfo: false,
                      title: "Description",
                      child: AppTextFields.simpleTextField(
                          name: "description",
                          hint: "A nickname you give to your account"),
                    ),
                    EachTextField(
                      hasInfo: false,
                      title: "Country",
                      child: FormBuilderField<String?>(builder: (FormFieldState field){
                        return DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "country in menu mode",
                            ),
                          ),
                          onChanged: (value) => field.didChange(value),
                        );
                      }, name: "country")
                    ),
                    ElevatedButton(onPressed: (){
                      print(formKey.currentState!.instantValue);
                    }, child: Text("confirm"))
                  ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),child: e,)).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EachTextField extends StatelessWidget {
  final String title;
  final bool hasInfo;
  final void Function()? onInfoTap;
  final Widget child;

  const EachTextField(
      {Key? key,
      required this.title,
      this.hasInfo = true,
      this.onInfoTap,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), const SizedBox(height: 8), child],
    );
  }
}
