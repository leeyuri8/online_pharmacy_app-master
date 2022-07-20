import 'package:drug_delivery_application/screens/pharmacey/PharmNavBar/PharmNavBar.dart';
import 'package:drug_delivery_application/screens/user/UserNavBar/UserNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../backend/firebase.dart';
import '../../../helpers/theme.dart';

class AddAddress extends StatefulWidget {
  final String name;
  final int isUser;
  const AddAddress(this.name, this.isUser, {Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
            child: Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset('assets/images/backarrow.svg')),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'addyouraddress'.tr,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: black1,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(
          height: 25.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'enteryourname'.tr,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: HexColor('#0C0B0B'),
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w800),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
          child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                controller: namecontroller,
                cursorColor: mainColor,
                decoration: InputDecoration(
                  labelText: 'Ahmed kh',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightGrey2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightGrey2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(
                      color: lightGrey,
                      fontSize: 14.sp,
                      fontFamily: montserratBold),
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'addaddress'.tr,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: HexColor('#0C0B0B'),
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w800),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
          child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                controller: addresscontroller,
                cursorColor: mainColor,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'addyouraddress'.tr,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightGrey2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightGrey2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(
                      color: lightGrey,
                      fontSize: 14.sp,
                      fontFamily: montserratBold),
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            if (addresscontroller.text.toString().isEmpty) {
              EasyLoading.showError('pleaseaddress'.tr);
            } else {
              EasyLoading.show(status: 'addingaddress'.tr);
              if (widget.isUser == 1) {
                addAddress(addresscontroller.text).then((value) {
                  if (value) {
                    EasyLoading.dismiss();
                    Get.offAll(() => UserNavBar());
                  }
                });
              } else {
                addPharmAddress(addresscontroller.text).then((value) {
                  if (value) {
                    EasyLoading.dismiss();
                    Get.offAll(() => PharmNavBar());
                  }
                });
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 70.h),
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50.h,
                  width: 274.w,
                  child: Center(
                    child: Text(
                      'save'.tr,
                      style: TextStyle(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: montserratBold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(21)),
                )),
          ),
        ),
      ]),
    );
  }
}
