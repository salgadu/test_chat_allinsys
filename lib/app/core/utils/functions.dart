import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mensageiro/app/core/components/svg_asset.dart';
import 'package:mensageiro/app/core/components/text.dart';
import 'package:mensageiro/app/core/constants/colors.dart';
import 'package:mensageiro/app/core/constants/fonts_sizes.dart';
import 'package:mensageiro/app/core/utils/screen_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

Future<void> getAllLanguages() async {}

Future<void> getTo({
  required Widget page,
  String? returnRoute,
  required String routeName,
  Transition? transition,
}) async {
  await Get.to(
    () => page,
    routeName: routeName,
    opaque: false,
    transition: transition,
  );
  // }
}

Future<void> showSnackbarError(String text) async {
  await Get.closeCurrentSnackbar();
  Get.showSnackbar(
    GetSnackBar(
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: 5,
      snackPosition: SnackPosition.TOP,
      maxWidth: 450,
      margin: EdgeInsets.only(
        top: ScreenHelper.doubleHeight(50),
        left: ScreenHelper.doubleHeight(ScreenHelper.isMobile ? 25 : 0),
        right: ScreenHelper.doubleHeight(ScreenHelper.isMobile ? 25 : 0),
      ),
      messageText: const SizedBox(),
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      titleText: Container(
        padding:
            const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                stops: [0.015, 0.015],
                colors: [Color(0xFFec4444), AppColors.white]),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.15),
                offset: const Offset(0, 18),
                blurRadius: 10,
                spreadRadius: -5,
              ),
            ]),
        child: Row(
          children: [
            const AppSvgAsset(
              imageW: 20,
              imageH: 20,
              image: 'warning.svg',
              color: Color(0xFFec4444),
            ),
            SizedBox(width: ScreenHelper.doubleWidth(20)),
            Expanded(
              child: AppText(
                text: text,
                fontSize: AppFontSize.fontSize4,
                maxLines: 4,
              ),
            ),
            SizedBox(width: ScreenHelper.doubleWidth(20)),
            InkWell(
              onTap: () async => await Get.closeCurrentSnackbar(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: AppSvgAsset(
                  image: 'close.svg',
                  imageH: 15,
                  imageW: 15,
                  color: AppColors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Future<void> showSnackbarMessage(String text) async {
  await Get.closeCurrentSnackbar();
  Get.showSnackbar(
    GetSnackBar(
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: 5,
      snackPosition: SnackPosition.TOP,
      maxWidth: 450,
      margin: EdgeInsets.only(
        top: ScreenHelper.doubleHeight(50),
        left: ScreenHelper.doubleHeight(20),
        right: ScreenHelper.doubleHeight(20),
      ),
      titleText: Row(
        children: [
          AppSvgAsset(
            image: "exclamation.svg",
            color: AppColors.black,
            imageH: ScreenHelper.doubleWidth(35),
            imageW: ScreenHelper.doubleWidth(35),
          ),
          SizedBox(
            width: ScreenHelper.doubleWidth(15),
          ),
          Expanded(
            child: AppText(
              text: text,
              maxLines: 3,
              fontSize: AppFontSize.fontSize6,
              color: AppColors.black,
            ),
          ),
          InkWell(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async => await Get.closeCurrentSnackbar(),
            child: AppSvgAsset(
              image: "close.svg",
              color: AppColors.black,
              imageH: ScreenHelper.doubleWidth(30),
              imageW: ScreenHelper.doubleWidth(30),
            ),
          ),
        ],
      ),
      messageText: const SizedBox(),
      backgroundColor: AppColors.white,
    ),
  );
}

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

String generateIdentifier(String identifier) {
  DateTime dt = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  return "$identifier${formatter.format(dt)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}";
}

String generateRemittanceIdentifier() {
  return "${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}";
}

String generateToken() {
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  String part1 =
      md5.convert(timestamp.toString().codeUnits).toString().substring(0, 5);
  String part2 = md5
      .convert(Random().nextInt(99999).toString().codeUnits)
      .toString()
      .substring(0, 5);
  return part1 + part2;
}

double getMoneyInValue(String money) {
  return double.tryParse(money.replaceAll(".", "").replaceAll(",", ".")) ?? 0.0;
}

String getMoneyOutValue(String money) {
  return double.parse(money.replaceAll(".", "").replaceAll(",", "."))
      .toStringAsFixed(2)
      .replaceAll(".", ",");
}

String formatDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  var formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}

//formate date to 25 Out 2023 às 20:45 in pt-br
String newFormatDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  initializeDateFormatting();

  var formatter = DateFormat('dd MMM yyyy', 'pt_BR');
  return '${formatter.format(dateTime).toUpperCase().capitalize} às ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

//Formate date as 15:00 em 12/08
String formatTimeDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} em ${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}';
}

Future<void> shareScreenshot(ScreenshotController controller,
    {String? name}) async {
  await Future.delayed(const Duration(milliseconds: 200));

  //load page

  final Directory dir = await getTemporaryDirectory();

  controller
      .capture(pixelRatio: 2, delay: const Duration(milliseconds: 00))
      .then((Uint8List? image) async {
    if (image != null) {
      String path = "/";

      final imagePath = await File('${dir.path}/screenshot.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareFiles([imagePath.path],
          text: name ??
              'Recibo de Abastecimento ${DateFormat('dd/MM/yyyy').format(DateTime.now())}');
    }
  });

  await Future.delayed(const Duration(milliseconds: 300));
}
