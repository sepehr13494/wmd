import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/dashboard_app_bar.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/help/faq/presentation/widgets/faq_item_list_view.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';
import 'package:wmd/features/help/support/presentation/widget/contact_business_team_widget.dart';
import 'package:wmd/features/help/support/presentation/widget/support_action_card_view.dart';
import 'package:wmd/injection_container.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  AppState<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends AppState<SupportPage> {
  void openEmailApp() async {
    String email = Uri.encodeComponent("business.support@tfoco.com");
    String subject = Uri.encodeComponent("");
    String body = Uri.encodeComponent("");
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }

  void handleOpenContactBusiness(context) {
    debugPrint("Open contact working");
    showDialog(
      context: context,
      builder: (context) {
        return ContactBusinessWidget(
          title: '[Asset] is successfully added to wealth overview',
          confirmBtn: "Submit",
        );
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return BlocProvider(
        create: (context) => sl<GeneralInquiryCubit>(),
        child: BlocConsumer<GeneralInquiryCubit, GeneralInquiryState>(
            listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {},
            ),
            builder: (context, state) {
              return Scaffold(
                  appBar: const DashboardAppBar(),
                  body: SingleChildScrollView(
                      padding: responsiveHelper.paddingForMobileTab,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: responsiveHelper.isMobile
                                  ? CrossAxisAlignment.center
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(12),
                                    child: const Icon(
                                      Icons.email,
                                      color: AppColors.primary,
                                    )),
                                Text(
                                  "Get Support",
                                  style: textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Start your global investment journey with no doubts or unclear points.",
                                  style: textTheme.bodySmall,
                                ),
                              ]),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                              width: responsiveHelper.optimalDeviceWidth,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: RowOrColumn(
                                      columnCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      rowCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      showRow: !responsiveHelper.isMobile,
                                      children: [
                                        ExpandedIf(
                                            expanded:
                                                !responsiveHelper.isMobile,
                                            child: SupportActionCard(
                                                icon: Icons.call,
                                                title:
                                                    "Talk to our business support team",
                                                desc:
                                                    "Request a call at your conveinence",
                                                action: () {})),
                                        responsiveHelper.isMobile
                                            ? const SizedBox(
                                                height: 16,
                                              )
                                            : const SizedBox(
                                                width: 16,
                                              ),
                                        ExpandedIf(
                                            expanded:
                                                !responsiveHelper.isMobile,
                                            child: SupportActionCard(
                                                icon: Icons.messenger_outlined,
                                                title:
                                                    "Contact our business support team",
                                                desc:
                                                    "Send a message to our business support team",
                                                action: () {
                                                  handleOpenContactBusiness(
                                                      context);
                                                })),
                                      ]))),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "FAQs",
                            style: textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const FaqItemList(),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Our contacts",
                            style: textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(12),
                                      child: const Icon(
                                        Icons.call,
                                        color: AppColors.primary,
                                      )),
                                  Text(
                                    "Email",
                                    style: textTheme.bodyMedium!.apply(
                                        color:
                                            AppColors.dashBoardGreyTextColor),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  openEmailApp();
                                },
                                child: Text(
                                  "business.support@tfoco.com",
                                  style: textTheme.bodyMedium!
                                      .toLinkStyle(context),
                                ),
                              )
                            ],
                          )
                        ],
                      )));
            }));
  }
}
