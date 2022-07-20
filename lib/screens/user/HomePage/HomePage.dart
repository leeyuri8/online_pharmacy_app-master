import 'package:badges/badges.dart';
import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/screens/user/FilterScreen/FilterScreen.dart';
import 'package:drug_delivery_application/screens/user/HomePage/cards/pharmaciesCard.dart';
import 'package:drug_delivery_application/screens/user/Medications/Medications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../helpers/theme.dart';
import '../AllPharmacey/AllPharmacey.dart';
import '../AllPharmacey/PharmaceyDetails/PharmaceyDetails.dart';
import '../Categories/Categories.dart';
import '../UserProfile/ProfileScreens/Notifications/Notifications.dart';
import 'cards/categoriesCard.dart';
import 'carouslimag.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'drugdelivery'.tr,
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: mainColor,
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => Notifications());
                  },
                  child: Badge(
                      showBadge:
                          appGet.notificationcounts.string.toString().isNotEmpty
                              ? true
                              : false,
                      badgeColor: HexColor('#D4721B'),
                      elevation: 0,
                      position: BadgePosition.topStart(start: 8, top: 2),
                      child:
                          SvgPicture.asset('assets/images/notification.svg')),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => FilterScreen());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3.0,
                    shadowColor: black,
                    child: TextField(
                      enabled: false,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        hintText: 'searchmedicine'.tr,
                        filled: true,
                        fillColor: white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Icon(
                          Icons.tune_rounded,
                          color: HexColor('#196737'),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: TextStyle(
                            color: HexColor('#196737'),
                            fontSize: 14.sp,
                            fontFamily: montserratBold),
                      ),
                    ),
                  )),
            ),
          ),
          const Carouslimg('assets/images/cursol.png'),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'categories'.tr,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: mainColor,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w800),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => Categories());
                  },
                  child: Text(
                    'seeall'.tr,
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: HexColor('#666769'),
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 200.h,
            child: StreamBuilder(
                stream: getAllCategories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.to(() => Medications(
                                      snapshot.data!.docs[index]['catId']
                                          .toString(),
                                      false,
                                      ''));
                                },
                                child: CategoriesCard(
                                  snapshot.data!.docs[index]['catId']
                                      .toString(),
                                  snapshot.data!.docs[index]['catName']
                                      .toString(),
                                  snapshot.data!.docs[index]['catImage']
                                      .toString(),
                                ));
                          },
                        )
                      : Text('');
                }),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 35.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'pharmacies'.tr,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: mainColor,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w800),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => AllPharmacey());
                  },
                  child: Text(
                    'seeall'.tr,
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: HexColor('#666769'),
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
              height: 200.h,
              child: StreamBuilder(
                  stream: getAllPharmacies(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => PharmaceyDetails(
                                        snapshot.data!.docs[index]['userId']
                                            .toString(),
                                        snapshot.data!.docs[index]['pharmName']
                                            .toString(),
                                        snapshot.data!.docs[index]['imageUrl']
                                            .toString(),
                                        snapshot.data!.docs[index]['address']
                                            .toString(),
                                        snapshot
                                            .data!.docs[index]['phoneNumber']
                                            .toString(),
                                        snapshot.data!.docs[index]['openHours']
                                            .toString(),
                                        double.parse(snapshot
                                            .data!.docs[index]['rating']
                                            .toString()),
                                      ));
                                },
                                child: PharmaciesCard(
                                  snapshot.data!.docs[index]['userId']
                                      .toString(),
                                  snapshot.data!.docs[index]['pharmName']
                                      .toString(),
                                  snapshot.data!.docs[index]['imageUrl']
                                      .toString(),
                                  snapshot.data!.docs[index]['address']
                                      .toString(),
                                  snapshot.data!.docs[index]['phoneNumber']
                                      .toString(),
                                  snapshot.data!.docs[index]['openHours']
                                      .toString(),
                                ),
                              );
                            },
                          )
                        : Text('');
                  })),
          SizedBox(
            height: 50.h,
          )
        ],
      ),
    );
  }
}
