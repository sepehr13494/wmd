import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/help/faq/presentation/manager/faq_cubit.dart';
import 'package:wmd/injection_container.dart';

class FaqItemList extends StatefulWidget {
  const FaqItemList({Key? key}) : super(key: key);

  @override
  AppState<FaqItemList> createState() => _FaqItemListState();
}

class _FaqItemListState extends AppState<FaqItemList> {
  List<bool> expanded = [false, false];

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return BlocProvider(
        create: (context) => sl<FaqCubit>()..getFAQs(),
        child: BlocConsumer<FaqCubit, FaqState>(listener:
            BlocHelper.defaultBlocListener(listener: (context, state) {
          if (state is FaqLoaded) {
            final faqList = state.faqs;

            setState(() {
              expanded = List<bool>.generate(faqList.length, (i) => false);
            });
          }
        }), builder: (context, state) {
          if (state is FaqLoaded) {
            final faqList = state.faqs;

            return ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    final currentList = expanded.map((x) => false).toList();
                    currentList[panelIndex] = !isExpanded;
                    expanded = currentList;
                    // expanded[panelIndex] = !isExpanded;
                  });
                },
                animationDuration: const Duration(seconds: 2),
                //animation duration while expanding/collapsing
                children: faqList.asMap().entries.map((entry) {
                  int idx = entry.key;
                  final currentFaq = entry.value;

                  return ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: AppColors.backgroundColorPageDark,
                      headerBuilder: (context, isOpen) {
                        return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              currentFaq.title ?? "",
                            ));
                      },
                      body: Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text(
                          currentFaq.description ?? "",
                          style: textTheme.bodySmall,
                        ),
                      ),
                      isExpanded: expanded[idx]);
                }).toList());
          } else {
            return const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "No FAQs found!",
                ));
          }
        }));
  }
}
