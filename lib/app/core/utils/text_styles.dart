import 'dart:ui';

import 'package:mensageiro/app/core/constants/fonts_sizes.dart';
import 'package:mensageiro/app/core/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_platform/universal_platform.dart';

TextStyle textStyle({
  bool inherit = true,
  Color? color,
  Color? backgroundColor,
  double fontSize = AppFontSize.fontSize5,
  String? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  TextLeadingDistribution? leadingDistribution,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  String? debugLabel,
  List<String>? fontFamilyFallback,
  String? package,
  TextOverflow? overflow,
}) {
  return TextStyle(
    inherit: inherit,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: (ScreenHelper.isMobile &&
            (UniversalPlatform.isAndroid || UniversalPlatform.isIOS))
        ? fontSize.sp
        : fontSize,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    leadingDistribution: leadingDistribution,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    debugLabel: debugLabel,
    fontFamily: fontWeight ?? "regular",
    fontFamilyFallback: fontFamilyFallback,
    package: package,
    overflow: overflow,
  );
}
