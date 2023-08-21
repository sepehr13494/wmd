import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/core/util/colors.dart';

import 'itd_ytd_shimmer.dart';

class EachAssetShimmer extends StatelessWidget {
  const EachAssetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ShimmerContainer(width: 140, height: 35),
                ),
                RowOrColumn(
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  showRow: !isMobile,
                  children: [
                    SizedBox(
                      width: !isMobile ? 200 : null,
                      child: const ShimmerContainer(
                        width: 110,
                        height: 28,
                      ),
                    ),
                    SizedBox(width: responsiveHelper.bigger16Gap, height: 16),
                    const ItdYtdShimmer()
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          ShimmerWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerContainer(width: 100, height: 12),
                ShimmerContainer(width: 80, height: 12),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
                color: AppColors.shimmerColor,
                borderRadius: BorderRadius.circular(8)),
            child: ShimmerWidget(
              secondColor: true,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerContainer(width: 100, height: 12),
                        ShimmerContainer(width: 80, height: 12),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerContainer(width: 50, height: 12),
                        ShimmerContainer(width: 80, height: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
