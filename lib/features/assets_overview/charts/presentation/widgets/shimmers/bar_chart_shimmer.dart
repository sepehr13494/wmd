import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/core/util/colors.dart';

class BarChartShimmer extends StatelessWidget {
  const BarChartShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snap) {
      return ShimmerWidget(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerContainer(width: 100, height: 20),
                ShimmerContainer(width: 80, height: 20),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: LayoutBuilder(builder: (context, snap) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(7, (index) {
                    final rand = Random().nextInt(snap.maxHeight.ceil() - 30);
                    return Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ShimmerContainer(
                          width: 10,
                          height: (30 + rand).toDouble(),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
            const SizedBox(height: 16),
            Wrap(
              children: List.generate(5, (index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: snap.maxWidth / 3,
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: ShimmerContainer(width: 80, height: 16),
                  ),
                );
              }),
            )
          ],
        ),
      );
    });
  }
}
