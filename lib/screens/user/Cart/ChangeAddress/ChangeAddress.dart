import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../backend/firebase.dart';
import '../../../../helpers/theme.dart';
import '../../Medications/appBar/AppBars.dart';

class ChangeAddress extends StatefulWidget {
  ChangeAddress({Key? key}) : super(key: key);

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBars('address'.tr, false, 93, true, 101),
        body: ListView(padding: EdgeInsets.only(bottom: 50.h), children: [
          Padding(
            padding: EdgeInsets.only(top: 37.h, left: 20.w, right: 20.w),
            child: Row(children: [
              SvgPicture.asset('assets/images/locationround.svg'),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'homeaddress'.tr,
                    style: TextStyle(
                        color: black,
                        fontSize: 14.sp,
                        fontFamily: poppins,
                        fontWeight: FontWeight.w600),
                  ),
                  Obx(
                    () => Text(
                      appGet.userMap['address'],
                      style: TextStyle(
                          color: HexColor('#A8A8A8'),
                          fontSize: 12.sp,
                          fontFamily: poppins),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
            child: Text(
              'changeaddress'.tr,
              style: TextStyle(
                  color: black,
                  fontSize: 16.sp,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 17.h),
            child: Align(
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: addressController,
                  cursorColor: mainColor,
                  maxLines: 5,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightGrey2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightGrey2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {
              if (addressController.text.isEmpty) {
                EasyLoading.showError("enteraddress".tr);
              } else {
                EasyLoading.show(status: "loading".tr);
                updateAddress(addressController.text.toString()).then((value) {
                  if (value == true) {
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess("updatedsuccess".tr);
                    getUserFromFirestore(userId: userIds, pass: appGet.pass);
                  }
                });
              }
            },
            child: Container(
                height: 52.h,
                width: 224.h,
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 54.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: mainColor),
                child: Center(
                    child: Text(
                  'changeaddress'.tr,
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w600,
                  ),
                ))),
          ),
        ]));
  }
}
