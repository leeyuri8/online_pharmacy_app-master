import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../../helpers/theme.dart';

class NotificationsCard extends StatefulWidget {
  final Timestamp datecreate;
  final String title;
  final String fcmorder;
  final String status;
  final String userId;
  final String details;
  NotificationsCard(this.datecreate, this.title, this.fcmorder, this.status,
      this.userId, this.details,
      {Key? key})
      : super(key: key);

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  String recivDate = '';
  String createdDate = '';
  @override
  void initState() {
    super.initState();
    createdDate = DateFormat('yyyy/MM/dd')
        .format(DateTime.parse(widget.datecreate.toDate().toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      margin: EdgeInsets.only(top: 40.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              children: [
                Container(
                  width: 89.w,
                  height: 85.h,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: HexColor('#D1D1D1'),
                      width: 1.0,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/medicines.svg',
                    height: 50.h,
                    width: 50.w,
                  ),
                ),
                SizedBox(width: 6.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 230.w,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: black1,
                            fontSize: 14.sp,
                            fontFamily: poppins,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      widget.details.toString(),
                      style: TextStyle(
                          color: HexColor('#AAAAAA'),
                          fontSize: 10.sp,
                          fontFamily: poppins),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      createdDate.toString(),
                      style: TextStyle(
                          color: black, fontSize: 10.sp, fontFamily: poppins),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            height: .5.h,
            color: HexColor('#D1D1D1'),
          )
        ],
      ),
    );
  }
}
