import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/core/util/colors.dart';

class NetWorthChartShimmer extends StatelessWidget {
  const NetWorthChartShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.shimmerColor,
      child: ShimmerWidget(
        secondColor: true,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShimmerContainer(width: 160, height: 30),
                  const Spacer(),
                  ShimmerContainer(width: 80, height: 30),
                ],
              ),
              const SizedBox(height: 8),
              ShimmerContainer(width: 100, height: 14),
              AspectRatio(
                aspectRatio:
                ResponsiveHelper(context: context).isMobile
                    ? 1.6
                    : 2.2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ShimmerContainer(width: double.maxFinite, height: double.maxFinite)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
