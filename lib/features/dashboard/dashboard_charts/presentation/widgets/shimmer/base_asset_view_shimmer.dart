import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/core/util/colors.dart';

class BaseAssetViewShimmer extends StatelessWidget {
  final Widget child;
  const BaseAssetViewShimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
            thickness: 0.7, color: AppColors.dashBoardGreyTextColor),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ShimmerWidget(
            secondColor: true,
            child: Column(
              children: [
                Row(
                  children: [
                    ShimmerContainer(width: 160, height: 30),
                    const Spacer(),
                    ShimmerContainer(width: 80, height: 30),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: child,
                ),
                Builder(builder: (context) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          ShimmerContainer(width: 80, height: 18),
                          const Spacer(),
                          ShimmerContainer(width: 80, height: 18),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                }),
                Builder(builder: (context) {
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              ShimmerContainer(width: 100, height: 18),
                              Spacer(),
                              ShimmerContainer(width: 120, height: 18),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, _) => const Divider(),
                      itemCount: 5);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
