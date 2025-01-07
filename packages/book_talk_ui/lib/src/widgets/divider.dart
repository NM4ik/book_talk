import 'package:flutter/material.dart';

class UiDivider extends Divider {
  final EdgeInsets? margin;

  UiDivider({
    super.key,
    super.height,
    super.thickness,
    super.indent = 1,
    super.endIndent,
    super.color,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: super.build(context),
    );
  }
}
