import 'package:drug_delivery_application/helpers/helper.dart';
import 'package:drug_delivery_application/screens/user/Cart/TrackOrder/TrackOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../backend/firebase.dart';
import '../../../../../helpers/theme.dart';
import '../../../../../helpers/utile.dart';

class MyOrdersCard extends StatefulWidget {
  final String address;
  final String note;
  final String orderNum;
  final String orderstatus;
  final String pharmName;
  final String pharmId;
  final List items;
  final String delvDate;
  MyOrdersCard(this.address, this.note, this.orderNum, this.orderstatus,
      this.pharmName, this.pharmId, this.items, this.delvDate,
      {Key? key})
      : super(key: key);

  @override
  State<MyOrdersCard> createState() => _MyOrdersCardState();
}

class _MyOrdersCardState extends State<MyOrdersCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.orderNum);
        appGet.orderId = widget.orderNum;
        print(appGet.orderId);
        getUserOrder(appGet.orderId).then((value) {
          Get.to(() => TrackOrder());
        });
      },
      child: Container(
          height: widget.orderstatus == '4' ? 223.h : 180.h,
          width: 344.w,
          margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(13.0),
            border: Border.all(
              color: HexColor('#D1D1D1'),
              width: 1.0,
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
              child: Text(
                '${'order'.tr} #${widget.orderNum}',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w600,
                    color: mainGreen),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 7.h),
              child: Text(
                widget.orderstatus == '1'
                    ? 'Ordered'
                    : widget.orderstatus == '2'
                        ? "shipped"
                        : widget.orderstatus == '3'
                            ? 'out for delivery'
                            : '${'deliverdon'.tr} ' ' ${widget.delvDate}',
                style: TextStyle(
                    fontSize: 12.sp, fontFamily: montserratBold, color: black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 9.h),
              height: 1.h,
              width: 324.w,
              color: HexColor('#D1D1D1'),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 12.w),
                    SvgPicture.asset('assets/images/market.svg'),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pharmName,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: poppins,
                              color: black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${widget.items.length} ${'items'.tr}',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: poppins,
                              color: HexColor('#A8A8A8')),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 40.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'details'.tr,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: poppins,
                          color: HexColor('#64AEDE'),
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 39.h,
                          width: 39.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: HexColor('#D1D1D1')),
                              color: white),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: WidgetRelease.getInstance().cashed(
                                widget.items[0]['medicineImage'],
                                50,
                                50,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Container(
                          height: 39.h,
                          width: 39.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: HexColor('#D1D1D1')),
                              color: white),
                          child: Center(
                            child: Text(
                              '+${widget.items.length - 1}',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: poppins,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#063E6E')),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                print(widget.orderNum);
                updateOrderStatus(1, widget.orderNum).then((value) {
                  successSanck(
                      'success'.tr, 'orderplaced'.tr, SnackPosition.BOTTOM);
                  getUserOrders();
                  sendTofcm('success'.tr, 'orderplaced'.tr, appGet.fcmToken,
                      widget.orderNum);
                });
              },
              child: Visibility(
                visible: widget.orderstatus == '4' ? true : false,
                child: Center(
                  child: Container(
                    height: 45.h,
                    width: 261.w,
                    decoration: BoxDecoration(
                        color: HexColor('#C5DBB2'),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/manual-task.svg'),
                        SizedBox(width: 10.w),
                        Text(
                          'reorder'.tr,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: montserratBold,
                              color: mainGreen,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
