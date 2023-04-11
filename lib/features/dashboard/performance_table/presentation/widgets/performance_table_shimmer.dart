import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';

class PerformanceTableShimmer extends StatelessWidget {
  final bool showTexts;
  const PerformanceTableShimmer({Key? key, this.showTexts = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTexts ? Column(
              children: const [
                ShimmerContainer(width: 200, height: 40),
                SizedBox(height: 24),
              ],
            ) : const SizedBox(),
            const ShimmerContainer(width: double.maxFinite, height: 250),
          ],
        ),
      ),

    );
  }
}
