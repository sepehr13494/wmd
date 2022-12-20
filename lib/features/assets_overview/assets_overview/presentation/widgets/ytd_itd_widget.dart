import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';


class YtdItdWidget extends StatelessWidget {
  final bool expand;
  final double ytd;
  final double itd;
  const YtdItdWidget({
    Key? key, this.expand = false,required this.ytd,required this.itd
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(2, (index) {
        final List items = [
          ["YTD", ytd, "$ytd%"],
          ["ITD", itd, "$itd%"],
        ];
        final item = items[index];
        return ExpandedIf(
          expanded: expand,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: expand? 2 : 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item[0],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const InfoIcon(),
                      ],
                    ),
                    ChangeWidget(number: item[1], text: item[2]),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}