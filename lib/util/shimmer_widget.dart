import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Color baseColor;
  final Color highlightColor;
  final bool isCircle;
  const ShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.radius = 5,
    required this.baseColor,
    required this.highlightColor,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          color: Apc.shimmer,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
