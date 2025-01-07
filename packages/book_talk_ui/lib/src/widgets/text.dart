import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';

class UiText extends StatelessWidget {
  const UiText._({
    required this.data,
    this.textStyle,
    this.textStyleBuilder,
    this.maxLines,
    this.textOverflow,
    this.textAlign,
    this.color,
    super.key,
  });

  factory UiText.displayLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.displayLarge,
        key: key,
      );

  factory UiText.displayMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.displayMedium,
        key: key,
      );

  factory UiText.displaySmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.displaySmall,
        key: key,
      );

  factory UiText.headlineLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.headlineLarge,
        key: key,
      );

  factory UiText.headlineMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.headlineMedium,
        key: key,
      );

  factory UiText.headlineSmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.headlineSmall,
        key: key,
      );

  factory UiText.titleLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.titleLarge,
        key: key,
      );

  factory UiText.titleMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.titleMedium,
        key: key,
      );

  factory UiText.titleSmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.titleSmall,
        key: key,
      );

  factory UiText.bodyLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.bodyLarge,
        key: key,
      );

  factory UiText.bodyMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.bodyMedium,
        key: key,
      );

  factory UiText.bodySmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.bodySmall,
        key: key,
      );

  factory UiText.labelLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.labelLarge,
        key: key,
      );

  factory UiText.labelMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.labelMedium,
        key: key,
      );

  factory UiText.labelSmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText._(
        data: data,
        color: color,
        textStyle: style,
        textAlign: textAlign,
        textOverflow: overflow,
        maxLines: maxLines,
        textStyleBuilder: (typography) => typography?.labelSmall,
        key: key,
      );

  /// The text to display
  final String data;

  final TextStyle? textStyle;

  /// Builder for text style based on [AppTypography].
  /// Custom settings
  final TextStyle? Function(AppTypography? typography)? textStyleBuilder;

  /// Max display lines for Text Widget
  final int? maxLines;

  /// Overflow style
  final TextOverflow? textOverflow;

  /// The self alignment of the text
  final TextAlign? textAlign;

  /// The color of the text
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final typograpy = Theme.of(context).appTypography;

    final style = textStyleBuilder?.call(typograpy) ?? typograpy?.bodyLarge;

    return Text(
      data,
      style: style?.copyWith(
        color: color ?? Theme.of(context).colorPalette?.foreground,
      ),
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
    );
  }
}
