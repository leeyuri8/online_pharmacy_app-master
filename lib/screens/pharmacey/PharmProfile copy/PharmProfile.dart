import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/helper.dart';
import 'package:drug_delivery_application/helpers/utile.dart';
import 'package:drug_delivery_application/lang/local.dart';
import 'package:drug_delivery_application/screens/pharmacey/PastOrder/pastOrders.dart';
import 'package:drug_delivery_application/screens/user/Cart/RateUs/RateUs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../helpers/theme.dart';
import '../../Login/Login.dart';
import '../../user/UserProfile/ProfileScreens/MyOrders/MyOrders.dart';


class PharmProfile extends StatefulWidget {
  PharmProfile({Key? key}) : super(key: key);

  @override
  State<PharmProfile> createState() => _PharmProfileState();
}

class _PharmProfileState extends State<PharmProfile> {
 User? user = FirebaseAuth.instance.currentUser;
 // var firestore = FirebaseFirestore.instance.collection("Pharmcies");
  
  bool _switchValue = true;
  

 var pharmEmail, pharmName, pharmImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
       body: ListView(padding: EdgeInsets.only(bottom: 50.h),
       
        children: [
      Container(
        height: 280.h,
        width: double.infinity,
        decoration: BoxDecoration(color: mainColor),
        child: Stack(
          children: [
               InkWell(
                  onTap: () {
                    displayPharmTextInputDialog(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset('assets/images/newmessage.svg'),
                    ),
                  ),
                ),
            Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: WidgetRelease.getInstance().cashed(
              appGet.pharmacyMap['imageUrl'],
              100,
              100,
            ),
          ),
                  Text(appGet.pharmacyMap['pharmName']
                     , style: TextStyle(
                        fontSize: 16.sp,
                        color: white,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(appGet.pharmacyMap['email'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: white,
                        fontFamily: montserratBold,
                      )),
                       SizedBox(
                    height: 10.h,
                  ),
                        Text('Opening Hours: ${appGet.pharmacyMap['openHours']}',
                      style: TextStyle(
                       fontSize: 12.sp,               
                        color: white,
                        fontFamily: montserratBold,
                      )
                      ),
                ],
              ),
            )
          ],
        ),
      ),
      InkWell(
        onTap: () {
          Get.to(() => PastOrders());
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 21.w),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/shopping-bag (2).svg'),
                  SizedBox(width: 16.w),
                  Text(
                    'pastorders'.tr,
                    style: TextStyle(
                        color: HexColor('#393939'),
                        fontSize: 14.sp,
                        fontFamily: poppins,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 1.h,
              width: double.infinity,
              color: HexColor('#D1D1D1'),
            )
          ],
        ),
      ),
      // Column(
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 21.w),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             children: [
      //               SvgPicture.asset('assets/images/bell.svg'),
      //               SizedBox(width: 16.w),
      //               Text(
      //                  'getnotification'.tr,
      //                 style: TextStyle(
      //                     color: HexColor('#393939'),
      //                     fontSize: 14.sp,
      //                     fontFamily: poppins,
      //                     fontWeight: FontWeight.w600),
      //               )
      //             ],
      //           ),
      //           FlutterSwitch(
      //             height: 20.0,
      //             width: 40.0,
      //             padding: 4.0,
      //             toggleSize: 15.0,
      //             borderRadius: 10.0,
      //             activeColor: mainColor,
      //             value: _switchValue,
      //             onToggle: (value) {
      //               setState(() {
      //                 _switchValue = value;
      //               });
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10.h,
      //     ),
      //     Container(
      //       height: 1.h,
      //       width: double.infinity,
      //       color: HexColor('#D1D1D1'),
      //     )
      //   ],
      // ),
      InkWell(
            onTap: () {
              if (appGet.lanid == 'English') {
                setState(() {
                  LocalizationService().changeLocale('Arabic');
                });
              } else {
                setState(() {
                  LocalizationService().changeLocale('English');
                });
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 26.w, top: 21.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.grey[700],
                        size: 30,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'changeLan'.tr,
                        style: TextStyle(
                            color: HexColor('#393939'),
                            fontSize: 14.sp,
                            fontFamily: poppins,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 1.h,
                  width: double.infinity,
                  color: HexColor('#D1D1D1'),
                )
              ],
            ),
          ),
            InkWell(
            onTap: () {
              Get.to(() => RateUs());
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 21.w),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/rateus.svg'),
                      SizedBox(width: 16.w),
                      Text(
                        'rateus'.tr,
                        style: TextStyle(
                            color: HexColor('#393939'),
                            fontSize: 14.sp,
                            fontFamily: poppins,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 1.h,
                  width: double.infinity,
                  color: HexColor('#D1D1D1'),
                )
              ],
            ),
          ),
         
        
    
      InkWell(
        onTap: () {
          Get.offAll(() => Login(2));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 21.w),
          child: Row(
            children: [
              SvgPicture.asset('assets/images/logout (1).svg'),
              SizedBox(width: 16.w),
              Text(
                'logout'.tr,
                style: TextStyle(
                    color: HexColor('#393939'),
                    fontSize: 14.sp,
                    fontFamily: poppins,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    ]
    )
             
       
  
  );
  }
}