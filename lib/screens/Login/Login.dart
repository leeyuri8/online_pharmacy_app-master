import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/chooseAccount/chooseAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../backend/firebase.dart';
import '../SignUp/SignUp.dart';
import '../pharmacey/PharmSignUp/PharmSignUp.dart';

class Login extends StatefulWidget {
  final int isUser;
  const Login(this.isUser, {Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Get.offAll(() => ChooseAccount());
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
                    'login'.tr,
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: black1,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'email'.tr,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGrey2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGrey2),
                      ),
                      labelStyle: TextStyle(
                          color: lightGrey,
                          fontSize: 14.sp,
                          fontFamily: montserratBold),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: visible,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'password'.tr,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGrey2),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: Icon(
                            visible == true
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: lightGrey2,
                          )),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGrey2),
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
                if (emailcontroller.text.toString().isEmpty) {
                  EasyLoading.showError('pleaseemail'.tr);
                } else if (passwordcontroller.text.toString().isEmpty) {
                  EasyLoading.showError('pleasepass'.tr);
                } else {
                  EasyLoading.show(status: 'loading'.tr);
                  signInWithEmailAndPassword(
                          email: emailcontroller.text.toString(),
                          password: passwordcontroller.text.toString(),
                          userOrPhram: widget.isUser)
                      .then((value) {
                    EasyLoading.dismiss();
                  });
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
                          'login'.tr,
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
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2.h,
                  width: 100.w,
                  color: lightGrey2,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  height: 2.h,
                  width: 100.w,
                  color: lightGrey2,
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {
                if (emailcontroller.text.toString().isEmpty) {
                  EasyLoading.showError('pleaseemail'.tr);
                } else {
                  sendPasswordResetEmail(emailcontroller.text.toString())
                      .then((value) {
                    EasyLoading.showSuccess('checkemail'.tr);
                  });
                }
              },
              child: Center(
                child: Text(
                  'forgetpassword'.tr,
                  style: TextStyle(
                      color: grey2,
                      fontSize: 13.sp,
                      fontFamily: montserratBold),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'donthaveacc'.tr,
                  style: TextStyle(
                      color: grey2,
                      fontSize: 14.sp,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    if (widget.isUser == 2) {
                      Get.to(() => PharmSignUp());
                    } else {
                      Get.to(() => SignUp());
                    }
                  },
                  child: Text(
                    'signup'.tr,
                    style: TextStyle(
                        color: green,
                        fontSize: 14.sp,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
