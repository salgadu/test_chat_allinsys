import 'package:mensageiro/app/core/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgAsset extends StatelessWidget {
  final String image;
  final double imageW;
  final double imageH;
  final Color? color;

  const AppSvgAsset(
      {Key? key,
      required this.image,
      this.imageW = 30,
      this.imageH = 30,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$image',
      width: ScreenHelper.doubleWidth(imageW),
      height: ScreenHelper.doubleHeight(imageH),
      color: color,
    );
  }
}
