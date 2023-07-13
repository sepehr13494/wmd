import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/app_localization.dart';

Future<bool?> showTermsModal({
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
        child: TermsWidget(),
        // actionsOverflowButtonSpacing: 0,
      );
    },
  );
}

class TermsWidget extends StatefulWidget {
  const TermsWidget({Key? key}) : super(key: key);

  @override
  AppState<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends AppState<TermsWidget> {
  final ScrollController scrollController = ScrollController();
  bool reachEnd = false;

  @override
  void initState() {
    scrollController.addListener(() async {
      if (!reachEnd) {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = 0.0; // or something else..
        if (maxScroll - currentScroll <= delta) {
          setState(() {
            reachEnd = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    const double iconSize = 5;
    final List<TermsData> data = getData(appLocalizations, textTheme);

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
              appLocalizations.termsAndConditions_tou_title,
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations.termsAndConditions_tou_description_one,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(height: 1.3),
                              children: [
                            TextSpan(
                              text: appLocalizations
                                  .termsAndConditions_tou_description_two_1,
                              style: textTheme.bodyMedium,
                            ),
                            TextSpan(
                                text: appLocalizations
                                    .termsAndConditions_tou_description_two_2,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: appLocalizations
                                  .termsAndConditions_tou_description_two_3,
                              style: textTheme.bodyMedium,
                            ),
                            TextSpan(
                                text: appLocalizations
                                    .termsAndConditions_tou_description_two_4,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: appLocalizations
                                  .termsAndConditions_tou_description_two_5,
                              style: textTheme.bodyMedium,
                            ),
                          ])),
                      const SizedBox(height: 8),
                      Text(
                        appLocalizations
                            .termsAndConditions_tou_description_three,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(height: 1.3),
                              children: [
                            TextSpan(
                                text:
                                    "${appLocalizations.termsAndConditions_tou_description_four_1} : ",
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: appLocalizations
                                    .termsAndConditions_tou_description_four_2,
                                style: textTheme.bodyMedium),
                            TextSpan(
                                text: appLocalizations
                                    .termsAndConditions_tou_description_four_3,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: appLocalizations
                                  .termsAndConditions_tou_description_four_4,
                              style: textTheme.bodyMedium,
                            ),
                          ])),
                      const SizedBox(height: 8),
                      // ...data.map((e) => Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Column(
                      //           children: const [
                      //             SizedBox(height: 8),
                      //             Icon(Icons.circle,
                      //                 color: Colors.white, size: iconSize),
                      //           ],
                      //         ),
                      //         const SizedBox(width: 4),
                      //         Expanded(child: e.title),
                      //       ],
                      //     )),
                      const SizedBox(height: 8),
                      ...List.generate(data.length, (index) {
                        final item = data[index];
                        final itemIndex = (index + 1).toString();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '$itemIndex. ',
                                  style: textTheme.bodyLarge,
                                ),
                                Expanded(child: item.title)
                              ],
                            ),
                            if (item.childrenWidget != null)
                              ...List.generate(item.childrenWidget!.length,
                                  (index) {
                                final e = item.childrenWidget![index];
                                final i = (index + 1).toString();
                                // ...e.children!.map((e) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      e,
                                    ]);
                              }),
                            if (item.children != null)
                              ...List.generate(item.children!.length, (index) {
                                final e = item.children![index];
                                final i = (index + 1).toString();
                                // ...e.children!.map((e) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$itemIndex.$i. ',
                                          style: textTheme.bodyLarge,
                                        ),
                                        Expanded(child: e.data!)
                                      ],
                                    ),
                                    if (e.childContent != null)
                                      ...e.childContent!.map((c) => Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 48),
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
                              }),
                          ],
                        );
                      }),
                      if (BlocProvider.of<LocalizationManager>(context)
                              .state
                              .languageCode ==
                          "ar")
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                                appLocalizations
                                    .termsAndConditions_arabicOnly_warning,
                                locale: const Locale('ar')),
                          ),
                        ),
                    ],
                  ),
                )),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: reachEnd
                          ? () {
                              Navigator.pop(context, true);
                            }
                          : null,
                      child: Text(appLocalizations.common_button_acceptAll)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(appLocalizations.common_button_cancel)),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class TermsData {
  final Widget title;
  final List<TermsChildData>? children;
  final List<Widget>? childrenWidget;

  TermsData(this.title, {this.children, this.childrenWidget});
}

class TermsChildData {
  final String? content;
  final Widget? data;
  final List<String>? childContent;
  final bool isBold;
  final bool isUnderline;

  TermsChildData(this.content,
      {this.childContent,
      this.isBold = false,
      this.isUnderline = false,
      this.data});
}

Widget renderRichText(List<TermsChildData> texts, TextTheme textTheme) {
  return RichText(
      text: TextSpan(style: const TextStyle(height: 1.3), children: [
    ...texts.map((TermsChildData e) {
      if (e.isBold) {
        return TextSpan(
            text: e.content,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold));
      } else if (e.isUnderline) {
        return TextSpan(
            text: e.content,
            style: textTheme.bodyMedium
                ?.copyWith(decoration: TextDecoration.underline));
      } else {
        return TextSpan(text: e.content, style: textTheme.bodyMedium);
      }
    })
  ]));
}

Widget renderText(TermsChildData texts, TextTheme textTheme) {
  if (texts.isBold) {
    return Text(texts.content!,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold));
  } else {
    return Text(
      texts.content!,
    );
  }
}

Widget renderRow(List<TermsChildData> texts, TextTheme textTheme) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ...texts.map((TermsChildData e) {
        return Expanded(child: Text(e.content!, style: textTheme.bodyMedium));
      })
    ],
  );
}

getData(AppLocalizations a, TextTheme textTheme) {
  return [
    TermsData(
        renderRichText([
          TermsChildData(a.termsAndConditions_tou_terms_one_title,
              isBold: true),
          TermsChildData(
            a.termsAndConditions_tou_terms_one_description,
          ),
        ], textTheme),
        childrenWidget: [
          renderRow([
            TermsChildData(
                a.termsAndConditions_tou_terms_one_confidential_title),
            TermsChildData(
                a.termsAndConditions_tou_terms_one_confidential_description),
          ], textTheme),
          renderRow([
            TermsChildData(
                a.termsAndConditions_tou_terms_one_consolidation_title),
            TermsChildData(
                a.termsAndConditions_tou_terms_one_consolidation_description),
          ], textTheme),
          renderRow([
            TermsChildData(a
                .termsAndConditions_tou_terms_one_consolidationStartDate_title),
            TermsChildData(a
                .termsAndConditions_tou_terms_one_consolidationStartDate_description),
          ], textTheme),
          renderRow([
            TermsChildData(
                a.termsAndConditions_tou_terms_one_dataProviders_title),
            TermsChildData(
                a.termsAndConditions_tou_terms_one_dataProviders_description),
          ], textTheme),
          renderRow([
            TermsChildData(a
                .termsAndConditions_tou_terms_one_effectiveTerminationDate_title),
            TermsChildData(a
                .termsAndConditions_tou_terms_one_effectiveTerminationDate_description),
          ], textTheme),
          renderRow([
            TermsChildData(a
                .termsAndConditions_tou_terms_one_intellectualPropertyRights_title),
            TermsChildData(a
                .termsAndConditions_tou_terms_one_intellectualPropertyRights_description),
          ], textTheme),
          renderRow([
            TermsChildData(
                a.termsAndConditions_tou_terms_one_licensedSoftware_title),
            TermsChildData(a
                .termsAndConditions_tou_terms_one_licensedSoftware_description),
          ], textTheme),
          renderRow([
            TermsChildData(a.termsAndConditions_tou_terms_one_portfolios_title),
            TermsChildData(
                a.termsAndConditions_tou_terms_one_portfolios_description),
          ], textTheme),
          renderRow([
            TermsChildData(
                a.termsAndConditions_tou_terms_one_positionData_title),
            TermsChildData(
                a.termsAndConditions_tou_terms_one_positionData_description),
          ], textTheme),
          renderRow([
            TermsChildData(a.termsAndConditions_tou_terms_one_services_title),
            TermsChildData(
                a.termsAndConditions_tou_terms_one_services_description),
          ], textTheme),
          renderRow([
            TermsChildData(a.termsAndConditions_tou_terms_one_term_title),
            TermsChildData(a.termsAndConditions_tou_terms_one_term_description),
          ], textTheme),
          renderRow([
            TermsChildData(
                a.termsAndConditions_tou_terms_one_transactionData_title),
            TermsChildData(
                a.termsAndConditions_tou_terms_one_transactionData_description),
          ], textTheme),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_one_services_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderRichText([
                TermsChildData("${a.termsAndConditions_tou_terms_two_1_a}: ",
                    isUnderline: true),
                TermsChildData(
                  a.termsAndConditions_tou_terms_two_1_b,
                ),
              ], textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_two_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_two_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_two_4),
                  textTheme),
              null),
          TermsChildData(
              data: renderRichText([
                TermsChildData("${a.termsAndConditions_tou_terms_two_5_a}: ",
                    isUnderline: true),
                TermsChildData(
                  a.termsAndConditions_tou_terms_two_5_b,
                ),
              ], textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_two_6),
                  textTheme),
              null),
          TermsChildData(
              data: renderRichText([
                TermsChildData("${a.termsAndConditions_tou_terms_two_7_a}: ",
                    isUnderline: true),
                TermsChildData(
                  a.termsAndConditions_tou_terms_two_7_b,
                ),
              ], textTheme),
              null,
              childContent: [
                a.termsAndConditions_tou_terms_two_7_c,
                a.termsAndConditions_tou_terms_two_7_d,
              ]),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_three_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_three_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_three_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_three_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_three_4),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_four_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_four_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_four_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_four_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_four_4),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_five_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_five_1),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_six_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_six_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_six_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_six_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_six_4),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_six_5),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_seven_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_seven_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_seven_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_seven_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_seven_4),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_seven_5),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_eight_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eight_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eight_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eight_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eight_4),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_nine_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_nine_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_nine_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_nine_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_nine_4),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_ten_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_4),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_5),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_6),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_7),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_8),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_ten_9),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_eleven_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eleven_1),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eleven_2),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eleven_3),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eleven_4),
                  textTheme),
              null),
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_eleven_5),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_twelve_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
              data: renderText(
                  TermsChildData(a.termsAndConditions_tou_terms_twelve_1),
                  textTheme),
              null),
        ]),
    TermsData(
        renderText(
            TermsChildData(a.termsAndConditions_tou_terms_thirteen_title,
                isBold: true),
            textTheme),
        children: [
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_1_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_1_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_2_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_2_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_3_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_3_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_4_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_4_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_5_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_5_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_6_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_6_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_7_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_7_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_8_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_8_b,
              ),
            ], textTheme),
            null,
          ),
          TermsChildData(
            data: renderRichText([
              TermsChildData("${a.termsAndConditions_tou_terms_thirteen_9_a}: ",
                  isUnderline: true),
              TermsChildData(
                a.termsAndConditions_tou_terms_thirteen_9_b,
              ),
            ], textTheme),
            null,
          ),
        ]),
  ];
}
