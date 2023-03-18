import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/base_asset_view_shimmer.dart';

class PieChartShimmer extends StatelessWidget {
  const PieChartShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAssetViewShimmer(
      child: LayoutBuilder(builder: (context, snap) {
        final double height = snap.maxWidth * 0.65;
        return ShimmerContainer(
          width: double.maxFinite,
          height: height,
        );
      }),
    );
  }
}
