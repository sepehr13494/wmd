import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';

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
                    const EachTextField(
                      hasInfo: false,
                      title: "Bank Name",
                      child: FormBuilderTypeAhead(name: "bank", hint: "bank hint", items: ["bank1","bank 2", "ARbsdfw"])
                    ),
                    EachTextField(
                      hasInfo: false,
                      title: "Description",
                      child: AppTextFields.simpleTextField(
                          name: "description",
                          hint: "A nickname you give to your account"),
                    ),
                    const EachTextField(
                      hasInfo: false,
                      title: "Country",
                      child: CountriesDropdown(),
                    ),
                    const EachTextField(
                      hasInfo: false,
                      title: "currency",
                      child: CurrenciesDropdown(),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print(formKey.currentState!.instantValue);
                        },
                        child: Text("confirm"))
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: e,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
