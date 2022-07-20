import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../helpers/theme.dart';
import '../../../../helpers/utile.dart';

class AllPharmceycard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String address;
  final String phone;
  final String openHours;
  AllPharmceycard(
      this.id, this.name, this.image, this.address, this.phone, this.openHours,
      {Key? key})
      : super(key: key);

  @override
  State<AllPharmceycard> createState() => _AllPharmceycardState();
}

class _AllPharmceycardState extends State<AllPharmceycard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172.h,
      width: 345.w,
      margin: EdgeInsets.only(top: 30.h, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: HexColor('#F9F9F9')),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: WidgetRelease.getInstance().cashed(
              widget.image,
              172,
              153,
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#196737'))),
              SizedBox(height: 13.h),
              Text(widget.address,
                  style: TextStyle(fontSize: 13.sp, color: grey2)),
            ],
          )
        ],
      ),
    );
  }
}
