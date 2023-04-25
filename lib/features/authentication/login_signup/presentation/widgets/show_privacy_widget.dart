import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool?> showPrivacyModal({
  required BuildContext context,
}) async {
  return await showDialog<bool?>(
    context: context,
    builder: (context) {
      return const Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        child: PrivacyWidget(),
        // actionsOverflowButtonSpacing: 0,
      );
    },
  );
}

class PrivacyWidget extends AppStatelessWidget {
  const PrivacyWidget({super.key});

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    const double iconSize = 5;
    final List<PrivacyData> data = getData(appLocalizations);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              appLocalizations.termsAndConditions_privacyPolicy_title,
              // appLocalizations.auth_signup_tos_title,
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations
                          .termsAndConditions_privacyPolicy_tableOfContent,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    ...data.map((e) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: const [
                                SizedBox(height: 8),
                                Icon(Icons.circle,
                                    color: Colors.white, size: iconSize),
                              ],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                                child: Text(
                              e.title,
                              maxLines: 10,
                            )),
                          ],
                        )),
                    const SizedBox(height: 8),
                    ...List.generate(data.length, (index) {
                      final e = data[index];
                      final i = (index + 1).toString();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '$i. ${e.title}',
                            style: textTheme.bodyLarge,
                          ),
                          if (e.children != null)
                            ...e.children!.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(e.content),
                                  if (e.childContent != null)
                                    ...e.childContent!.map((c) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 8),
                                            Column(
                                              children: const [
                                                SizedBox(height: 8),
                                                Icon(Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: iconSize),
                                              ],
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                                child: Text(
                                              c,
                                              maxLines: 10,
                                            )),
                                          ],
                                        ))
                                ],
                              );
                            })
                        ],
                      );
                    })
                  ],
                ),
              )),
            ),
          ),
        ]),
      ),
    );
  }
}

class PrivacyData {
  final String title;
  final List<PrivacyChildData>? children;

  PrivacyData(this.title, {this.children});
}

class PrivacyChildData {
  final String content;
  final List<String>? childContent;

  PrivacyChildData(this.content, {this.childContent});
}

getData(AppLocalizations a) {
  return [
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_definitions_name,
        children: [
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_definitions_description_one),
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_definitions_description_two),
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_definitions_description_three),
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_definitions_description_four),
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_definitions_description_five),
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_definitions_description_six),
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_definitions_description_seven_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_definitions_description_seven_1,
                a.termsAndConditions_privacyPolicy_policies_definitions_description_seven_2,
                a.termsAndConditions_privacyPolicy_policies_definitions_description_seven_3,
                a.termsAndConditions_privacyPolicy_policies_definitions_description_seven_4,
                a.termsAndConditions_privacyPolicy_policies_definitions_description_seven_5,
                a.termsAndConditions_privacyPolicy_policies_definitions_description_seven_6,
              ]),
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_definitions_description_eight_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_definitions_description_eight_1,
                a.termsAndConditions_privacyPolicy_policies_definitions_description_eight_2,
                a.termsAndConditions_privacyPolicy_policies_definitions_description_eight_3,
              ]),
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_introduction_name,
        children: [
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_introduction_description_one),
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_introduction_description_two),
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_circumstances_name,
        children: [
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_circumstances_description_one),
          PrivacyChildData(a
              .termsAndConditions_privacyPolicy_policies_circumstances_description_two),
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_circumstances_description_three_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_circumstances_description_three_1,
                a.termsAndConditions_privacyPolicy_policies_circumstances_description_three_2,
                a.termsAndConditions_privacyPolicy_policies_circumstances_description_three_3,
              ]),
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_about_name,
        children: [
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_about_description_one_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_about_description_one_1,
                a.termsAndConditions_privacyPolicy_policies_about_description_one_2,
                a.termsAndConditions_privacyPolicy_policies_about_description_one_3,
                a.termsAndConditions_privacyPolicy_policies_about_description_one_4,
                a.termsAndConditions_privacyPolicy_policies_about_description_one_5,
                a.termsAndConditions_privacyPolicy_policies_about_description_one_6,
                a.termsAndConditions_privacyPolicy_policies_about_description_one_7,
                a.termsAndConditions_privacyPolicy_policies_about_description_one_8,
              ])
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_basis_name,
        children: [
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_basis_description_one_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_1,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_2,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_3,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_4,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_5,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_6,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_7,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_8,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_9,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_10,
                a.termsAndConditions_privacyPolicy_policies_basis_description_one_11,
              ]),
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_crossBorder_name,
        children: [
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_crossBorder_description_one,
          ),
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_crossBorder_description_two,
          ),
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_crossBorder_description_three,
          ),
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_crossBorder_description_four_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_crossBorder_description_four_1,
                a.termsAndConditions_privacyPolicy_policies_crossBorder_description_four_2,
                a.termsAndConditions_privacyPolicy_policies_crossBorder_description_four_3,
                a.termsAndConditions_privacyPolicy_policies_crossBorder_description_four_4,
                a.termsAndConditions_privacyPolicy_policies_crossBorder_description_four_5,
              ]),
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_retention_name,
        children: [
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_retention_description_one_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_retention_description_one_1
              ])
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_security_name,
        children: [
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_security_description_one,
          ),
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_security_description_two,
          ),
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_security_description_three,
          ),
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_rights_name,
        children: [
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_rights_description_one_description,
            childContent: [
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_1,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_2,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_3,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_4,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_5,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_6,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_7,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_8,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_9,
              a.termsAndConditions_privacyPolicy_policies_rights_description_one_10,
            ],
          ),
          PrivacyChildData(
            a.termsAndConditions_privacyPolicy_policies_rights_description_two,
          ),
        ]),
    PrivacyData(a.termsAndConditions_privacyPolicy_policies_contact_name,
        children: [
          PrivacyChildData(
              a.termsAndConditions_privacyPolicy_policies_contact_description_one_description,
              childContent: [
                a.termsAndConditions_privacyPolicy_policies_contact_description_one_1,
                a.termsAndConditions_privacyPolicy_policies_contact_description_one_2,
                a.termsAndConditions_privacyPolicy_policies_contact_description_one_3,
              ])
        ]),
  ];
}
