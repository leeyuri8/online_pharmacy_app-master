import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/helpers/utile.dart';
import 'package:drug_delivery_application/screens/Login/Login.dart';
import 'package:drug_delivery_application/screens/user/Cart/ChangeAddress/ChangeAddress.dart';
import 'package:drug_delivery_application/screens/user/Cart/RateUs/RateUs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../helpers/helper.dart';
import '../../../lang/local.dart';
import 'ProfileScreens/Favorite/Favourite.dart';
import 'ProfileScreens/MyOrders/MyOrders.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _switchValue = true;
  @override
  void initState() {
    super.initState();
    getAllFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(padding: EdgeInsets.only(bottom: 50.h), children: [
          Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(color: mainColor),
              child: Stack(children: [
                InkWell(
                  onTap: () {
                    displayTextInputDialog(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset('assets/images/newmessage.svg'),
                    ),
                  ),
                ),
                Obx(
                  () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: WidgetRelease.getInstance().cashed(
                        appGet.userMap['imageUrl'],
                      100,
                      100,
            ),
          ),
           SizedBox(
                          height: 10.h,
                        ),

                        Text(appGet.userMap['userName'],
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: white,
                              fontFamily: montserratBold,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(appGet.userMap['email'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: white,
                              fontFamily: montserratBold,
                            )),
                      ],
                    ),
                  ),
                )
              ])),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ChangeAddress());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 45.w),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/home (4).svg'),
                      SizedBox(width: 16.w),
                      Text(
                        'changeaddress'.tr,
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
          InkWell(
            onTap: () {
              Get.to(() => MyOrders());
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
                        'myorders'.tr,
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
              Get.to(() => Favourite());
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 21.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/heart (3).svg'),
                          SizedBox(width: 16.w),
                          Text(
                            'favourite'.tr,
                            style: TextStyle(
                                color: HexColor('#393939'),
                                fontSize: 14.sp,
                                fontFamily: poppins,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Obx(
                        () => Text(
                          '${appGet.favList.length} items',
                          style: TextStyle(
                              color: HexColor('#393939'),
                              fontSize: 12.sp,
                              fontFamily: montserratBold,
                              fontWeight: FontWeight.w600),
                        ),
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
          //                 'getnotification'.tr,
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
          // Column(
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 21.w),
          //       child: Row(
          //         children: [
          //           SvgPicture.asset('assets/images/question.svg'),
          //           SizedBox(width: 16.w),
          //           Text(
          //             'help'.tr,
          //             style: TextStyle(
          //                 color: HexColor('#393939'),
          //                 fontSize: 14.sp,
          //                 fontFamily: poppins,
          //                 fontWeight: FontWeight.w600),
          //           )
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
                  padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 21.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.grey[700],
                        size: 30,
                      ),
                      SizedBox(width: 16.w),
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
              Get.offAll(() => Login(1));
              signOut();
              kiltoken();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 26.w, top: 21.w),
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
        ]),
      ),
    );
  }
}
