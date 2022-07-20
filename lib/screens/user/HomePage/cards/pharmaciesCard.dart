import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/theme.dart';
import '../../../../helpers/utile.dart';

class PharmaciesCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String address;
  final String phone;
  final String openHours;
  PharmaciesCard(
      this.id, this.name, this.image, this.address, this.phone, this.openHours,
      {Key? key})
      : super(key: key);

  @override
  State<PharmaciesCard> createState() => _PharmaciesCardState();
}

class _PharmaciesCardState extends State<PharmaciesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 150.w,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: white),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: WidgetRelease.getInstance().cashed(
          widget.image,
          120,
          120,
        ),
      ),
    );
  }
}
