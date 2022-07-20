import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

successSanck(String title, String message, SnackPosition pos) {
  Get.snackbar("", "",
      colorText: white,
      shouldIconPulse: true,
      titleText: Text(
        title,
        style: TextStyle(
            fontSize: 14.sp,
            color: white,
            fontWeight: FontWeight.w600,
            fontFamily: montserratBold),
      ),
      messageText: Text(
        message,
        style: TextStyle(
            fontSize: 14.sp, color: white, fontFamily: montserratBold),
      ),
      icon: Icon(Icons.check_rounded, size: 20, color: white),
      barBlur: 10,
      margin: const EdgeInsets.all(20),
      snackPosition: pos,
      isDismissible: true,
      backgroundColor: mainColor,
      duration: const Duration(seconds: 3));
}

errorSanck(String title, String message, SnackPosition pos) {
  Get.snackbar("", "",
      colorText: white,
      shouldIconPulse: true,
      titleText: Text(
        title,
        style: TextStyle(
            fontSize: 14.sp,
            color: white,
            fontWeight: FontWeight.w600,
            fontFamily: montserratBold),
      ),
      messageText: Text(
        message,
        style: TextStyle(
            fontSize: 14.sp, color: white, fontFamily: montserratBold),
      ),
      icon: Icon(Icons.close, size: 20, color: white),
      barBlur: 10,
      margin: const EdgeInsets.all(20),
      snackPosition: pos,
      isDismissible: true,
      backgroundColor: HexColor('#FF6347'),
      duration: const Duration(seconds: 3));
}

String formatStringOneChar(String data) {
  var number = data.replaceAll("\$", "").replaceAll(",", "");
  return "${NumberFormat("#0", "en_US").format(double.parse(number))}";
}

Future<void> displayTextInputDialog(
  BuildContext context,
) async {
  TextEditingController name = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        name.text = appGet.userMap['userName'];
        return AlertDialog(
          title: Text(
            'updateyourdata'.tr,
            style: TextStyle(fontSize: 15.sp, color: black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "name".tr,
                  hintStyle: TextStyle(fontSize: 13.sp),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            TextButton(
            //  textColor: black,
              child: Text('cancel'.tr),
              onPressed: () {
                Get.back();
              },
            ),
            // ignore: deprecated_member_use
            TextButton(
              // minWidth: 20.w,
              // color: mainColor,
              // textColor: white,
              child: Text('ok'.tr),
              onPressed: () {
                updateUserData(name.text).then((value) {
                  getUserFromFirestore(
                      userId: appGet.tokenuser, pass: appGet.pass);
                  print(value);
                  if (value == true) {
                    successSanck("success".tr, "updatedsuccess".tr,
                        SnackPosition.BOTTOM);
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ],
        );
      });
}
Future<void> displayPharmTextInputDialog(
  BuildContext context,
) async {
  TextEditingController name = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        name.text = appGet.pharmacyMap['pharmName'];
        return AlertDialog(
          title: Text(
            'updateyourdata'.tr,
            style: TextStyle(fontSize: 15.sp, color: black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "name".tr,
                  hintStyle: TextStyle(fontSize: 13.sp),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            TextButton(
            //  textColor: black,
              child: Text('cancel'.tr),
              onPressed: () {
                Get.back();
              },
            ),
            // ignore: deprecated_member_use
            TextButton(
              // minWidth: 20.w,
              // color: mainColor,
              // textColor: white,
              child: Text('ok'.tr),
              onPressed: () {
                updatePharmData(name.text).then((value) {
                  getPharmFromFirestore(
                      userId: appGet.tokenuser, pass: appGet.pass);
                  print(value);
                  if (value == true) {
                    successSanck("success".tr, "updatedsuccess".tr,
                        SnackPosition.BOTTOM);
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ],
        );
      });
}

Future<void> samePharm(
  BuildContext context,
) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'samepharm'.tr,
            style: TextStyle(fontSize: 15.sp, color: black),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            TextButton(
             // textColor: black,
              child: Text('cancel'.tr),
              onPressed: () {
                Get.back();
              },
            ),
            // ignore: deprecated_member_use
           TextButton(
              // minWidth: 20.w,
              // color: red,
              // textColor: white,
              child: Text('ok'.tr),
              onPressed: () {},
            ),
          ],
        );
      });
}


