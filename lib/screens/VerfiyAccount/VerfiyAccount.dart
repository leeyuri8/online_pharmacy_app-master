import 'dart:async';
import 'dart:ui';

import 'package:drug_delivery_application/screens/user/AddAddress/AddAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../helpers/theme.dart';

class VerfiyAccount extends StatefulWidget {
  const VerfiyAccount({Key? key}) : super(key: key);

  @override
  State<VerfiyAccount> createState() => _VerfiyAccountState();
}

class _VerfiyAccountState extends State<VerfiyAccount> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
                  'Enter Verfication code',
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: black1,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: 70.h,
          ),
          Form(
            key: formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  textStyle: TextStyle(color: white),
                  pastedTextStyle: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: true,
                  obscuringWidget: SvgPicture.asset('assets/images/dots.svg'),
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(13),
                    fieldHeight: 71,
                    fieldWidth: 71,
                    activeFillColor: mainColor,
                    inactiveFillColor: mainColor,
                    selectedColor: mainColor,
                    selectedFillColor: mainColor,
                    inactiveColor: mainColor,
                    activeColor: mainColor,
                  ),
                  cursorColor: white,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    return true;
                  },
                )),
          ),
          SizedBox(
            height: 130.h,
          ),
          GestureDetector(
            onTap: () {
              //       Get.to(() => AddAddress());
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
                        'Verify',
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
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Text(
              'Resend Code',
              style: TextStyle(
                  color: grey2,
                  fontSize: 14.sp,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
