import 'dart:io';
import 'package:drug_delivery_application/screens/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../backend/firebase.dart';
import '../../helpers/theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  String phonee = "+970";

  bool visible = true;

  XFile? pickedImages;
  String? base64Image;
  final ImagePicker picker = ImagePicker();
  Future getimagdata(BuildContext context) async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "imagesource".tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 22.sp, fontFamily: montserratBold, color: black),
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text(
                    "camera".tr,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: montserratBold,
                        color: black),
                  ),
                  onPressed: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
                MaterialButton(
                  child: Text(
                    "gallery".tr,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: montserratBold,
                        color: black),
                  ),
                  onPressed: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                )
              ],
            ));

    if (imageSource != null) {
      var imgfil = await picker.pickImage(source: imageSource);
      print('images is full');

      pickedImages = imgfil;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(bottom: 50.h),
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
                    'createacc'.tr,
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: black1,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {
                getimagdata(context);
              },
              child: pickedImages == null
                  ? Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: lightGrey2,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: grey,
                          size: 30,
                        ),
                      ))
                  : Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              // fit: BoxFit.fitWidth,
                              image: FileImage(
                            File(pickedImages!.path),
                          ))),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
              child: Text(
                'addidentity'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.sp, color: black1, fontFamily: montserratBold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: namecontroller,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'username'.tr,
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
                    controller: emailcontroller,
                    cursorColor: mainColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'emailsignup'.tr,
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
                    cursorColor: mainColor,
                    obscureText: visible,
                    decoration: InputDecoration(
                      labelText: 'password'.tr,
                      enabledBorder: UnderlineInputBorder(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 100.w,
                          padding: EdgeInsets.only(
                              left: 17.w, right: 17.w, top: 20.h),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: phonee,
                                hint: Text(
                                  phonee,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: montserratBold,
                                      color: black),
                                ),
                                items: appGet.catNames.isNotEmpty
                                    ? (["+970", "+972"]).map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontFamily: montserratBold,
                                                color: black),
                                          ),
                                        );
                                      }).toList()
                                    : null,
                                onChanged: (newValue) {
                                  setState(() {
                                    phonee = newValue!;
                                    print(phonee);
                                  });
                                },
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 180.w,
                        child: TextField(
                          controller: phonecontroller,
                          cursorColor: mainColor,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'phonenum'.tr,
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
                        ),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                if (pickedImages == null) {
                  EasyLoading.showError('pleaseidentity'.tr);
                } else if (namecontroller.text.toString().isEmpty) {
                  EasyLoading.showError('pleasename'.tr);
                } else if (emailcontroller.text.toString().isEmpty) {
                  EasyLoading.showError('pleaseemail'.tr);
                } else if (passwordcontroller.text.toString().isEmpty) {
                  EasyLoading.showError('pleasepass'.tr);
                } else if (phonecontroller.text.toString().isEmpty) {
                  EasyLoading.showError('pleasepass'.tr);
                } else {
                  EasyLoading.show(status: 'loading'.tr);
                  registrationProcess(
                          name: namecontroller.text.toString(),
                          email: emailcontroller.text.toString(),
                          password: passwordcontroller.text.toString(),
                          mobile: phonee + phonecontroller.text.toString(),
                          address: '',
                          isUser: true)
                      .then((value) {
                    uploadIdentityImage(File(pickedImages!.path), userIds)
                        .then((value) {
                      EasyLoading.dismiss();
                    });
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
                          'signup'.tr,
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
                Text(
                  'alreadyhaveacc'.tr,
                  style: TextStyle(
                      color: grey2,
                      fontSize: 14.sp,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => Login(1));
                  },
                  child: Text(
                    'login'.tr,
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
