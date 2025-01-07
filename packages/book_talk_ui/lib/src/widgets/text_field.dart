import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldVariant {
  standart,
}

class UiTextField extends StatelessWidget {
  const UiTextField.standart({
    super.key,
    this.controller,
    this.obscureText = false,
    this.hintText,
    this.suffixIcon,
    this.onEditingComplete,
    this.inputFormatters,
    this.focus,
    this.edgeInsets,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.buildCounter,
    this.onChanged,
  }) : _variant = TextFieldVariant.standart;

  final TextEditingController? controller;
  final FocusNode? focus;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onEditingComplete;
  final TextFieldVariant _variant;
  final EdgeInsets? edgeInsets;
  final int? maxLength;
  final Function(String)? onChanged;
  final TextAlign textAlign;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).appTypography!;
    final palette = Theme.of(context).colorPalette!;

    return TextField(
      controller: controller,
      textAlign: textAlign,
      obscureText: obscureText,
      style: typography.bodyMedium,
      onEditingComplete: onEditingComplete,
      focusNode: focus,
      maxLength: maxLength,
      buildCounter: buildCounter,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: switch (_variant) {
        TextFieldVariant.standart => _StandartUiTextFieldStyle(
            palette: palette,
            hintText: hintText,
            suffixIcon: suffixIcon,
            appTypography: typography,
            edgeInsets: edgeInsets,
          ),
      },
    );
  }
}

class _StandartUiTextFieldStyle extends UiTextFieldStyle {
  const _StandartUiTextFieldStyle({
    required this.palette,
    required this.appTypography,
    required this.edgeInsets,
    super.hintText,
    super.suffixIcon,
  });

  final ColorPalette palette;
  final AppTypography appTypography;
  final EdgeInsets? edgeInsets;

  @override
  InputBorder? get border => InputBorder.none;

  @override
  bool? get filled => true;

  @override
  Color? get fillColor => palette.secondary;

  @override
  InputBorder? get focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: palette.primary,
          width: 1,
        ),
      );

  @override
  TextStyle? get hintStyle => appTypography.bodyMedium;

  @override
  InputBorder? get disabledBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(4),
      );

  @override
  BoxConstraints? get constraints => const BoxConstraints(minHeight: 32);

  @override
  EdgeInsetsGeometry? get contentPadding =>
      edgeInsets ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 18);

  @override
  InputBorder? get enabledBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(4),
      );

  @override
  bool? get isDense => true;
}

class UiTextFieldStyle extends InputDecoration {
  const UiTextFieldStyle({
    super.icon,
    super.iconColor,
    super.label,
    super.labelText,
    super.labelStyle,
    super.floatingLabelStyle,
    super.helper,
    super.helperText,
    super.helperStyle,
    super.helperMaxLines,
    super.hintText,
    super.hintStyle,
    super.hintTextDirection,
    super.hintMaxLines,
    super.hintFadeDuration,
    super.error,
    super.errorText,
    super.errorStyle,
    super.errorMaxLines,
    super.floatingLabelBehavior,
    super.floatingLabelAlignment,
    super.isCollapsed,
    super.isDense,
    super.contentPadding,
    super.prefixIcon,
    super.prefixIconConstraints,
    super.prefix,
    super.prefixText,
    super.prefixStyle,
    super.prefixIconColor,
    super.suffixIcon,
    super.suffix,
    super.suffixText,
    super.suffixStyle,
    super.suffixIconColor,
    super.suffixIconConstraints,
    super.counter,
    super.counterText,
    super.counterStyle,
    super.filled,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.errorBorder,
    super.focusedBorder,
    super.focusedErrorBorder,
    super.disabledBorder,
    super.enabledBorder,
    super.border,
    super.enabled = true,
    super.semanticCounterText,
    super.alignLabelWithHint,
    super.constraints,
    this.textStyle,
    this.cursorColor,
    this.cursorWidth = 1,
    this.cursorHeight,
  });

  /// The style to use for the text being edited.
  final TextStyle? textStyle;

  /// The color to use for the cursor.
  final Color? cursorColor;

  /// The width of the cursor.
  final double cursorWidth;

  /// The height of the cursor.
  final double? cursorHeight;

  /// Merge two [UiTextFieldStyle] objects.
  ///
  /// If a property is not null in [other], it will be used,
  /// otherwise the property from `this` will be used.
  UiTextFieldStyle merge(UiTextFieldStyle? other) {
    if (other == null) return this;
    return UiTextFieldStyle(
      icon: other.icon ?? icon,
      iconColor: other.iconColor ?? iconColor,
      label: other.label ?? label,
      labelText: other.labelText ?? labelText,
      labelStyle: other.labelStyle ?? labelStyle,
      floatingLabelStyle: other.floatingLabelStyle ?? floatingLabelStyle,
      helper: other.helper ?? helper,
      helperText: other.helperText ?? helperText,
      helperStyle: other.helperStyle ?? helperStyle,
      helperMaxLines: other.helperMaxLines ?? helperMaxLines,
      hintText: other.hintText ?? hintText,
      hintStyle: other.hintStyle ?? hintStyle,
      hintTextDirection: other.hintTextDirection ?? hintTextDirection,
      hintMaxLines: other.hintMaxLines ?? hintMaxLines,
      hintFadeDuration: other.hintFadeDuration ?? hintFadeDuration,
      error: other.error ?? error,
      errorText: other.errorText ?? errorText,
      errorStyle: other.errorStyle ?? errorStyle,
      errorMaxLines: other.errorMaxLines ?? errorMaxLines,
      floatingLabelBehavior:
          other.floatingLabelBehavior ?? floatingLabelBehavior,
      floatingLabelAlignment:
          other.floatingLabelAlignment ?? floatingLabelAlignment,
      isCollapsed: other.isCollapsed ?? isCollapsed,
      isDense: other.isDense ?? isDense,
      contentPadding: other.contentPadding ?? contentPadding,
      prefixIcon: other.prefixIcon ?? prefixIcon,
      prefixIconConstraints:
          other.prefixIconConstraints ?? prefixIconConstraints,
      prefix: other.prefix ?? prefix,
      prefixText: other.prefixText ?? prefixText,
      prefixStyle: other.prefixStyle ?? prefixStyle,
      prefixIconColor: other.prefixIconColor ?? prefixIconColor,
      suffixIcon: other.suffixIcon ?? suffixIcon,
      suffix: other.suffix ?? suffix,
      suffixText: other.suffixText ?? suffixText,
      suffixStyle: other.suffixStyle ?? suffixStyle,
      suffixIconColor: other.suffixIconColor ?? suffixIconColor,
      suffixIconConstraints:
          other.suffixIconConstraints ?? suffixIconConstraints,
      counter: other.counter ?? counter,
      counterText: other.counterText ?? counterText,
      counterStyle: other.counterStyle ?? counterStyle,
      filled: other.filled ?? filled,
      fillColor: other.fillColor ?? fillColor,
      focusColor: other.focusColor ?? focusColor,
      hoverColor: other.hoverColor ?? hoverColor,
      errorBorder: other.errorBorder ?? errorBorder,
      focusedBorder: other.focusedBorder ?? focusedBorder,
      focusedErrorBorder: other.focusedErrorBorder ?? focusedErrorBorder,
      disabledBorder: other.disabledBorder ?? disabledBorder,
      enabledBorder: other.enabledBorder ?? enabledBorder,
      border: other.border ?? border,
      enabled: other.enabled,
      semanticCounterText: other.semanticCounterText ?? semanticCounterText,
      alignLabelWithHint: other.alignLabelWithHint ?? alignLabelWithHint,
      constraints: other.constraints ?? constraints,
      textStyle: other.textStyle ?? textStyle,
      cursorColor: other.cursorColor ?? cursorColor,
      cursorWidth: cursorWidth,
      cursorHeight: other.cursorHeight ?? cursorHeight,
    );
  }
}
