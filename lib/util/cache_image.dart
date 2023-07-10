import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class CacheImage extends StatelessWidget {
  final Widget? child;
  final String url;
  final double height;
  final double width;
  final double radius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BoxFit fit;
  const CacheImage({
    super.key,
    this.height = 0.0,
    required this.url,
    this.width = 0.0,
    this.radius = 10,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.fit = BoxFit.cover,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          margin: margin,
          padding: padding,
          height: height == 0.0 ? null : height,
          width: width == 0.0 ? null : width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
          child: child,
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Apc.whiteColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                value: progress.progress,
                strokeWidth: 1.5,
                valueColor: const AlwaysStoppedAnimation<Color>(Apc.blackColor),
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Apc.greyColor,
            borderRadius: BorderRadius.circular(radius),
          ),
        );
      },
    );
  }
}
