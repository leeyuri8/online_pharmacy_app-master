import 'dart:core';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/helpers/utile.dart';
import 'package:drug_delivery_application/screens/user/Medications/Medications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class AllOederCard extends StatefulWidget {
  final String orderNumber;
  final String address;
  final String deliveryDate;
  final String pharmId;
  final  List items ;
  final String orderStatus;
  final String note;
  

  const AllOederCard( this.orderNumber,  this.address,  this.deliveryDate,  this.pharmId,    this.items,   this.orderStatus,  this.note,  {Key? key}) : super(key: key);
  
  
  

  @override
  _AllOederCardState createState() => _AllOederCardState();
}

class _AllOederCardState extends State<AllOederCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Center(
          child: Container(
            padding: EdgeInsets.only(
              right:5.w,
              left: 15.w,
            ),
            width: 380.w,
            height: 200.h,
            decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(13.r),
            border: Border.all(
              color: bordergrey,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 145.w,
                    height: 26.h,
                    decoration: BoxDecoration(
                      color: lightgreen,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Center(
                      child: Text(
                       'neworderrequest'.tr,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: montserratBold,
                          color: mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.deliveryDate,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: montserratBold,
                      color: bordergrey,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'order'.tr} ${widget.orderNumber}',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: montserratBold,
                            color: black2,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 170.w,
                        height: 35.h,
                        child: Text(
                          '${widget.items.length} ${'items'.tr}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: poppins,
                            color: lightgrey1,
                          ),
                        ),
                      ),
                              Text(
                'address'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: poppins,
                  color: black,
                ),
              ),
              SizedBox(
                width: 219.w,
                child: Text(
                  '${widget.address}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: poppins,
                    color: lightgrey1,
                  ),
                ),
              ),
                    ],
                  ),
            
       
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
          ),
       
      ])
    
     ])) ));
    
  }
}
