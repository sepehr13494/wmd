import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';

class ItdYtdShimmer extends StatelessWidget {
  final bool expand;
  const ItdYtdShimmer({Key? key, this.expand = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(2, (index) {
        return ExpandedIf(
          expanded: expand,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: expand ? 2 : 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerContainer(width: 40, height: 14),
                    const SizedBox(height: 4),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: const ShimmerContainer(width: 40, height: 14),
                    ),
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
