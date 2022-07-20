import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../helpers/theme.dart';
import '../../../../helpers/utile.dart';

class MedicationsCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;
  final String categoryId;
  final String avalibilty;
  final String howToUse;
  final String pharmId;

  MedicationsCard(this.id, this.name, this.image, this.price, this.description,
      this.categoryId, this.avalibilty, this.howToUse, this.pharmId,
      {Key? key})
      : super(key: key);

  @override
  State<MedicationsCard> createState() => _MedicationsCardState();
}

class _MedicationsCardState extends State<MedicationsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185.h,
      width: 141.w,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(3, 25),
            ),
          ],
          color: HexColor('#FAFBFB')),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: WidgetRelease.getInstance().cashed(
              widget.image,
              120,
              141,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            widget.name,
            style: TextStyle(
                color: HexColor('#666769'),
                fontSize: 11.sp,
                fontFamily: montserratBold),
          ),
          SizedBox(height: 10.h),
          Text(
            '₪${widget.price}',
            style: TextStyle(
                color: HexColor('#196737'),
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                fontFamily: montserratBold),
          ),
        ],
      ),
    );
  }
}
