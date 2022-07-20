// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetRelease {
  static WidgetRelease Widgetinstable = WidgetRelease();

  static WidgetRelease getInstance() {
    if (Widgetinstable == null) {
      Widgetinstable = new WidgetRelease();
    }
    return Widgetinstable;
  }

  Widget loading() {
    return Center(
      child: Image.asset(
        'assets/images/loading.gif',
        width: (100).w,
        height: (100).h,
      ),
    );
  }

  Widget cashed(String url, int hight, int width) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width.w,
      height: hight.h,
      placeholder: (context, url) => WidgetRelease.getInstance().loading(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }

  void whatsAppOpen(String number) async {
    bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

    if (whatsapp) {
      await FlutterLaunch.launchWhatsapp(phone: number, message: "Hello");
    } else {
      print("Whatsapp not installed");
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static String deviceId = "";
  static String TypeDevice = "";
  static String TokenFCM = "";

  void init(BuildContext context) {
    firebaseMessaging;

    getTokenFCM();
    /* getUId();*/
    getUId().then((value) {
      deviceId = value!;
      print(deviceId);
    });
  }

  getTokenFCM() {
    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      TokenFCM = token!;
    }).catchError((err) {
      print('Erorr token: FCM');
    });
  }

  Future<String?> getUId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      TypeDevice = "IOS"; // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      TypeDevice = "android"; // import 'dart:io'

      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}
