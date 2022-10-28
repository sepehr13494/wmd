import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';

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
      bottomSheet: AddAssetFooter(buttonText: "Add asset", onTap: (){
        print(formKey.currentState!.instantValue);
      }),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormBuilderTypeAhead(
                                name: "bank",
                                hint: "bank hint",
                                items: ["bank1", "bank 2", "ARbsdfw"]),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Link your bank account",
                                style: textTheme.titleSmall!.apply(
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        )),
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
                    EachTextField(
                      title: "Account Type",
                      child: AppTextFields.dropDownTextField(
                        name: "accountType",
                        hint: "Type or select account type",
                        items: [
                          "Saving account",
                          "current account",
                          "Term deposit"
                        ]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                    ),
                    const EachTextField(
                      hasInfo: false,
                      title: "currency",
                      child: CurrenciesDropdown(),
                    ),
                    EachTextField(
                      title: "Ownership",
                      child: AppTextFields.simpleTextField(
                          name: "ownership",
                          hint: "50%",
                          keyboardType: TextInputType.number),
                    ),
                    EachTextField(
                      title: "Principal (original deposit amount)",
                      child: AppTextFields.simpleTextField(
                          name: "principal", hint: "\$20,000"),
                    ),
                    EachTextField(
                      title: "Rate (optional)",
                      child: AppTextFields.simpleTextField(
                          name: "rate", hint: "50.00", required: false),
                    ),
                    EachTextField(
                      title: "Start date",
                      child: FormBuilderDateTimePicker(
                        inputType: InputType.date,
                        name: "startDate",
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: "02/11/2022"),
                      ),
                    ),
                    EachTextField(
                        title: "Tenure",
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: EachTextField(
                                  hasInfo: false,
                                  title: "Years",
                                  child: AppTextFields.simpleTextField(
                                    name: "years",
                                    hint: "00",
                                    keyboardType: TextInputType.number
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: EachTextField(
                                  hasInfo: false,
                                  title: "Months",
                                  child: AppTextFields.simpleTextField(
                                      name: "months",
                                      hint: "00",
                                      keyboardType: TextInputType.number
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: EachTextField(
                                  hasInfo: false,
                                  title: "Days",
                                  child: AppTextFields.simpleTextField(
                                      name: "days",
                                      hint: "00",
                                      keyboardType: TextInputType.number
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 60),
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
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
