import 'package:drug_delivery_application/screens/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/theme.dart';

class ChooseAccount extends StatefulWidget {
  ChooseAccount({Key? key}) : super(key: key);

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          SizedBox(
            height: 80.h,
          ),
          SvgPicture.asset(
            'assets/images/onboard3.svg',
            height: 300,
            width: 200,
          ),
          SizedBox(
            height: 80.h,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => Login(1));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 80.h,
                    width: 274.w,
                    child: Center(
                      child: Text(
                        'loginasuser'.tr,
                        style: TextStyle(
                            color: white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: montserratBold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: mainColor,
                        border: Border.all(color: mainColor, width: 2.w),
                        borderRadius: BorderRadius.circular(21)),
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => Login(2));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 80.h,
                    width: 274.w,
                    child: Center(
                      child: Text(
                        'loginaspharmacy'.tr,
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: montserratBold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: mainColor, width: 2.w),
                        borderRadius: BorderRadius.circular(21)),
                  )),
            ),
          ),
        ],
      )),
    );
  }
}
