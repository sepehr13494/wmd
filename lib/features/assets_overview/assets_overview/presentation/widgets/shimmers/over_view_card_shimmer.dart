import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/core/util/colors.dart';

import 'itd_ytd_shimmer.dart';

class OverviewCardShimmer extends StatelessWidget {
  const OverviewCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.shimmerColor),
      padding: EdgeInsets.all(responsiveHelper.bigger24Gap),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ShimmerWidget(
          secondColor: true,
          child: RowOrColumn(
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            showRow: !isMobile,
            children: [
              ExpandedIf(
                expanded: !isMobile,
                child: Align(
                  alignment: isMobile
                      ? AlignmentDirectional.centerStart
                      : Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerContainer(width: 160, height: 20),
                      SizedBox(height: responsiveHelper.bigger16Gap),
                      const ShimmerContainer(width: 120, height: 30),
                    ],
                  ),
                ),
              ),
              !isMobile
                  ? Container(
                margin: EdgeInsets.symmetric(
                    horizontal: responsiveHelper.bigger16Gap),
                width: 1,
                height: 120,
                color: Theme.of(context).dividerColor,
                child: Divider(
                  thickness: 1,
                  color: Theme.of(context).dividerColor,
                ),
              )
                  : Divider(
                thickness: 1,
                color: Theme.of(context).dividerColor,
                height: 48,
              ),
              ExpandedIf(
                expanded: !isMobile,
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerContainer(width: 160, height: 20),
                    SizedBox(height: responsiveHelper.bigger16Gap),
                    RowOrColumn(
                      showRow: !isMobile,
                      children: [
                        ExpandedIf(
                          flex: 4,
                          expanded: !isMobile,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const ShimmerContainer(width: 100, height: 14),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  ShimmerContainer(width: 40, height: 14),
                                  SizedBox(width: 4),
                                  ShimmerContainer(width: 40, height: 14),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24, width: 4),
                        ExpandedIf(
                          flex: 5,
                          expanded: !isMobile,
                          child: ItdYtdShimmer(
                            expand: !isMobile,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
