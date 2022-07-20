import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helpers/theme.dart';

class IconAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final String icon;
  IconAppBar(this.title, this.height, this.icon, {Key? key}) : super(key: key);

  @override
  State<IconAppBar> createState() => _IconAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height.h);
}

class _IconAppBarState extends State<IconAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        height: 93.h,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            border: Border.all(color: grey2),
            color: mainColor),
        child: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/images/Shape.svg',
                    color: white,
                    height: 16.h,
                    width: 25.w,
                  )),
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: white,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w800),
              ),
              SvgPicture.asset(widget.icon)
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(widget.height.h),
    );
  }
}
