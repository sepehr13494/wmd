import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/base_asset_view_shimmer.dart';

class MapChartShimmer extends StatelessWidget {
  const MapChartShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAssetViewShimmer(
      child: LayoutBuilder(builder: (context, snap) {
        return ShimmerContainer(width: double.maxFinite, height: snap.maxWidth * 0.65,);
      },),
    );
  }
}
