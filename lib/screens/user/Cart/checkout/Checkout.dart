import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/screens/user/Cart/DoneOrder/DoneOrder.dart';
import 'package:drug_delivery_application/screens/user/Cart/checkout/ordercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../helpers/theme.dart';
import '../../Medications/appBar/AppBars.dart';
import 'package:expandable/expandable.dart';

class CheckOut extends StatefulWidget {
  CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBars('checkout'.tr, false, 93, true, 101),
        body: ListView(padding: EdgeInsets.only(bottom: 50.h), children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h, right: 30.w, left: 30.w),
            child: ExpandablePanel(
              header: Text(
                'shippingaddress'.tr,
                style: TextStyle(
                    color: HexColor('#3D3E41'),
                    fontSize: 16.sp,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w700),
              ),
              collapsed: ListView(
                shrinkWrap: true,
                children: [
                  Row(children: [
                    Text(
                      '${'name'.tr} :',
                      style: TextStyle(
                          color: HexColor('#A8A8A8'),
                          fontSize: 12.sp,
                          fontFamily: montserratBold),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      appGet.userMap['userName'],
                      style: TextStyle(
                          color: HexColor('#A8A8A8'),
                          fontSize: 12.sp,
                          fontFamily: montserratBold),
                    ),
                  ]),
                  SizedBox(height: 10.h),
                  Row(children: [
                    Text(
                      '${'emailsignup'.tr} :',
                      style: TextStyle(
                          color: HexColor('#A8A8A8'),
                          fontSize: 12.sp,
                          fontFamily: montserratBold),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      appGet.userMap['email'],
                      style: TextStyle(
                          color: HexColor('#A8A8A8'),
                          fontSize: 12.sp,
                          fontFamily: montserratBold),
                    ),
                  ]),
                  SizedBox(height: 10.h),
                  Row(children: [
                    Text(
                      '${'phonenum'.tr} :',
                      style: TextStyle(
                          color: HexColor('#A8A8A8'),
                          fontSize: 12.sp,
                          fontFamily: montserratBold),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      appGet.userMap['phoneNumber'],
                      style: TextStyle(
                          color: HexColor('#A8A8A8'),
                          fontSize: 12.sp,
                          fontFamily: montserratBold),
                    ),
                  ]),
                  SizedBox(height: 20.h),
                  Row(children: [
                    SvgPicture.asset('assets/images/market.svg'),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appGet.cartList[0]['pharmName'],
                          style: TextStyle(
                              color: black,
                              fontSize: 14.sp,
                              fontFamily: poppins,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${appGet.cartList.length} ${'items'.tr} ',
                          style: TextStyle(
                              color: HexColor('#A8A8A8'),
                              fontSize: 12.sp,
                              fontFamily: poppins),
                        ),
                      ],
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(left: 7.w),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset('assets/images/line.svg')),
                  ),
                  Row(children: [
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
                        Text(
                          appGet.userMap['address'],
                          style: TextStyle(
                              color: HexColor('#A8A8A8'),
                              fontSize: 12.sp,
                              fontFamily: poppins),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(height: 20.h),
                  Container(
                    height: 1.h,
                    width: 335.w,
                    color: HexColor('#C3C3C3'),
                  )
                ],
              ),
              expanded: Text(''),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h, right: 30.w, left: 30.w),
            child: Text(
              'orderdetails'.tr,
              style: TextStyle(
                  color: HexColor('#3D3E41'),
                  fontSize: 16.sp,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 22.h),
          ListView.builder(
            itemCount: appGet.cartList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  OrderCard(
                    appGet.cartList[index]['medicineImage'].toString(),
                    appGet.cartList[index]['totalPrice'].toString(),
                    appGet.cartList[index]['quntity'].toString(),
                    appGet.cartList[index]['medicineName'].toString(),
                  ),
                  Container(
                    height: .5.h,
                    width: 335.w,
                    margin: EdgeInsets.only(left: 13.w, right: 13.w),
                    color: HexColor('#C3C3C3'),
                  ),
                  SizedBox(height: 22.h),
                ],
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h, right: 30.w, left: 30.w),
            child: Text(
              '${'note'.tr}:',
              style: TextStyle(
                  color: HexColor('#3D3E41'),
                  fontSize: 16.sp,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, right: 30.w, left: 30.w),
            child: Text(
              'deliverycost'.tr,
              style: TextStyle(
                  color: HexColor('#A8A8A8'),
                  fontSize: 14.sp,
                  fontFamily: poppins),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h, right: 30.w, left: 30.w),
            child: Text(
              'yournote'.tr,
              style: TextStyle(
                  color: HexColor('#3D3E41'),
                  fontSize: 16.sp,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Align(
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: noteController,
                  cursorColor: mainColor,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'writenote'.tr,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightGrey2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightGrey2),
                      borderRadius: BorderRadius.circular(10.r),
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
              addOrder(appGet.cartList[0]['pharmaceyId'],
                      appGet.cartList[0]['pharmName'], noteController.text, 1)
                  .then((value) {
                if (value == true) {
                  deleteCart();
                  sendTofcm('success'.tr, 'orderplaced'.tr, appGet.fcmToken,
                      appGet.orderId);
                  Get.to(() => DoneOrder());
                } else {}
              });
            },
            child: Container(
                height: 50.h,
                width: 224.h,
                margin: EdgeInsets.only(left: 55.w, right: 55.w, top: 15.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: mainColor),
                child: Center(
                    child: Text(
                  'checkout'.tr,
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontFamily: poppins,
                  ),
                )
              )
           ),
          ),
        ]));
  }
}
