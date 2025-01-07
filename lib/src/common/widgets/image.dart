import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart' as image;

typedef WidgetBuilder = Widget Function(BuildContext context);

class CachedNetworkImage extends StatelessWidget {
  const CachedNetworkImage._({
    required this.url,
    super.key,
    this.nullOrEmptyBuilder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.boxFit,
  });

  factory CachedNetworkImage.url({
    Key? key,
    required String? url,
    WidgetBuilder? nullOrEmptyBuilder,
    Widget Function(BuildContext, String, image.DownloadProgress)?
        progressIndicatorBuilder,
    Widget Function(BuildContext, String, Object)? errorWidget,
    BoxFit? boxFit,
  }) =>
      CachedNetworkImage._(
        key: key,
        url: url,
        nullOrEmptyBuilder: nullOrEmptyBuilder,
        progressIndicatorBuilder: progressIndicatorBuilder,
        errorWidget: errorWidget,
        boxFit: boxFit,
      );

  final String? url;
  final WidgetBuilder? nullOrEmptyBuilder;
  final Widget Function(BuildContext, String, image.DownloadProgress)?
      progressIndicatorBuilder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    final imageUrl = url;

    if (imageUrl == null || imageUrl.isEmpty) {
      return nullOrEmptyBuilder == null
          ? const SizedBox.shrink()
          : nullOrEmptyBuilder!.call(context);
    }

    return image.CachedNetworkImage(
      imageUrl: imageUrl,
      fit: boxFit,
      progressIndicatorBuilder: progressIndicatorBuilder,
      errorWidget: errorWidget,
    );
  }
}
