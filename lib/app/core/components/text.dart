import 'package:mensageiro/app/core/constants/colors.dart';
import 'package:mensageiro/app/core/constants/fonts_sizes.dart';
import 'package:mensageiro/app/core/utils/text_styles.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontWeight;
  final Color color;
  final double? letterSpacing;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? height;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  const AppText({
    Key? key,
    required this.text,
    this.fontSize = AppFontSize.fontSize5,
    this.fontWeight = "regular",
    this.color = AppColors.black,
    this.letterSpacing,
    this.textAlign,
    this.height,
    this.maxLines,
    this.decoration,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: EasyRichText(
        text,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        defaultStyle: textStyle(
            color: color,
            overflow: TextOverflow.ellipsis,
            fontSize: fontSize,
            fontStyle: fontStyle,
            height: height,
            fontWeight: fontWeight,
            decoration: decoration,
            letterSpacing: letterSpacing),
        patternList: [
          //
          //#gfdgfgfgfgfgg#dsdsds
          //#gfdgdfgdfg#
          //dsdsdsd{Afttdfgdf65656dfdf}}fhgh{frgfgfg}dfd
          EasyRichTextPattern(
            targetString: '(\\*)(.*?)(\\*)',
            matchBuilder: (BuildContext? context, RegExpMatch? match) {
              return TextSpan(
                text: match![0]!.replaceAll('*', ''),
                style: textStyle(
                    color: color,
                    height: height,
                    fontSize: fontSize,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: "bold",
                    decoration: decoration,
                    letterSpacing: letterSpacing),
              );
            },
          ),
        ],
      ),
    );
  }
}
