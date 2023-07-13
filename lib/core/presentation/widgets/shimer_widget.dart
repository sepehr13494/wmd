import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wmd/core/util/colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final bool secondColor;

  const ShimmerWidget({Key? key, this.width, this.height, this.child,this.secondColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool effect = true;
    if(kIsWeb){
      if(kIsWeb){
        effect = false;
      }
    }
    return Builder(
      builder: (context) {
        Widget shimmerChild = child ?? Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: AppColors.shimmerColor,
              borderRadius: BorderRadius.circular(8)
          ),
        );
        return SizedBox(
          width: width,
          height: height,
          child: !effect ? shimmerChild : Shimmer.fromColors(
            baseColor: secondColor ? AppColors.shimmerSecondColor : AppColors.shimmerColor,
            highlightColor: Colors.black,
            enabled: effect,
            child: shimmerChild,
          ),
        );
      }
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;
  const ShimmerContainer({Key? key, required this.width, required this.height, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: AppColors.shimmerColor,
          borderRadius: BorderRadius.circular(radius ?? 8)
      ),
    );
  }
}

