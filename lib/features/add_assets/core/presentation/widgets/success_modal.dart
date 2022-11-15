import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class SuccessModalWidget extends ModalWidget {
  final String aquiredCost, marketPrice, netWorth, netWorthChange;

  const SuccessModalWidget({
    super.key,
    required super.title,
    super.body,
    required super.confirmBtn,
    required super.cancelBtn,
    required this.aquiredCost,
    required this.marketPrice,
    required this.netWorth,
    required this.netWorthChange,
  });

  @override
  Widget buildDialogContent(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return SizedBox(
      width: double.infinity,
      height: isMobile
          ? MediaQuery.of(context).size.height * 0.7
          : MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          buildModalHeader(context),
          Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: responsiveHelper.bigger16Gap,
                          horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: responsiveHelper.xxLargeFontSize),
                          ),
                          SizedBox(height: responsiveHelper.biggerGap),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Aquired cost',
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                      height: responsiveHelper.defaultSmallGap),
                                  Text(
                                    aquiredCost,
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodyLarge,
                                  ),
                                  SizedBox(
                                      height: responsiveHelper.defaultSmallGap),
                                  Text(
                                    'Market Value: $marketPrice',
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Net Worth',
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                      height: responsiveHelper.defaultSmallGap),
                                  Text(
                                    netWorth,
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodyLarge,
                                  ),
                                  SizedBox(
                                      height: responsiveHelper.defaultSmallGap),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.green[400],
                                      ),
                                      Text(
                                        netWorthChange,
                                        textAlign: TextAlign.center,
                                        style: appTextTheme.bodySmall
                                            ?.merge(TextStyle(
                                          color: Colors.green[400],
                                        )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    buildActionContainer(context),
                    SizedBox(
                      height: responsiveHelper.bigger16Gap * 3,
                    )
                  ]))
        ],
      ),
    );
  }

  ///  Action Buttons Container of Modal
  @override
  Widget buildActionContainer(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsiveHelper.bigger16Gap * 5),
        child: RowOrColumn(
          showRow: !isMobile,
          children: [
            ExpandedIf(
              expanded: !isMobile,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                style:
                    OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
                child: Text(
                  cancelBtn,
                ),
              ),
            ),
            !isMobile
                ? SizedBox(width: responsiveHelper.bigger16Gap)
                : SizedBox(height: responsiveHelper.bigger16Gap),
            ExpandedIf(
                expanded: !isMobile,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  child: Text(confirmBtn),
                ))
          ],
        ));
  }
}
