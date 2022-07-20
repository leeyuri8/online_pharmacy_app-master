import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/user/Cart/RateUs/RateUs.dart';
import 'package:drug_delivery_application/screens/user/Cart/TrackOrder/TrackOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../backend/firebase.dart';

class DoneOrder extends StatefulWidget {
  DoneOrder({Key? key}) : super(key: key);

  @override
  State<DoneOrder> createState() => _DoneOrderState();
}

class _DoneOrderState extends State<DoneOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          SizedBox(height: 160.h),
          Container(
            height: 142.h,
            width: 142.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                  )
                ]),
            child: Center(
              child: Icon(Icons.check, color: white, size: 50.w),
            ),
          ),
          SizedBox(height: 30.h),
          Center(
            child: Text(
              'yourorder'.tr,
              style: TextStyle(
                  color: mainColor,
                  fontSize: 17.sp,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 12.h),
          Center(
            child: Text(
              'yourorderwasplaced'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: HexColor('#A8A8A8'),
                  fontSize: 12.sp,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w600),
            ),
          ),
          GestureDetector(
            onTap: () {
              print(appGet.orderId);
              getUserOrder(appGet.orderId).then((value) {
                Get.to(() => TrackOrder());
              });
            },
            child: Container(
                height: 50.h,
                width: 200.h,
                margin: EdgeInsets.only(left: 90.w, right: 90.w, top: 50.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: mainColor),
                child: Center(
                    child: Text(
                  'trackorder'.tr,
                  style: TextStyle(
                    color: white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: montserratBold,
                  ),
                ))),
          ),
          SizedBox(height: 30.h),
          InkWell(
            onTap: () {
              Get.to(() => RateUs());
            },
            child: Center(
                child: Text(
              'rateus'.tr,
              style: TextStyle(
                color: mainColor,
                decoration: TextDecoration.underline,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: montserratBold,
              ),
            )),
          )
        ],
      )),
    );
  }
}
