import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_platform/universal_platform.dart';

class ScreenHelper {
  ScreenHelper._privateConstructor();

  static final ScreenHelper _instance = ScreenHelper._privateConstructor();

  factory ScreenHelper() {
    return _instance;
  }

  static bool get isMobile => Get.size.width <= 550;
  static bool get isTablet => (Get.size.width > 550) && (Get.size.width < 1024);
  static bool get isDesktopOrWeb => Get.size.width >= 1024;

  static double doubleWidth(double width) {
    return (isMobile &&
            (UniversalPlatform.isAndroid || UniversalPlatform.isIOS))
        ? (width).w
        : width;
  }

  static double doubleHeight(double height) {
    return (isMobile &&
            (UniversalPlatform.isAndroid || UniversalPlatform.isIOS))
        ? (height).w
        : height;
  }

  static double getValueDouble(dynamic) {
    return double.tryParse((dynamic ?? "").toString()) ?? 0.0;
  }

  static String? returnValueOrNull(dynamic value) {
    return (value ?? "").toString().trim().isEmpty
        ? null
        : (value ?? "").toString();
  }
}
