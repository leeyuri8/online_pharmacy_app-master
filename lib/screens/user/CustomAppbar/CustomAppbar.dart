import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../helpers/theme.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final bool isNotification;
  const CustomAppbar(this.isNotification, {Key? key}) : super(key: key);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(134.h);
}

class _CustomAppbarState extends State<CustomAppbar> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            border: Border.all(color: grey2),
            color: mainColor),
        child: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          'assets/images/Shape.svg',
                          color: white,
                          height: 16.h,
                          width: 25.w,
                        )),
                  ),
                  Visibility(
                    visible: widget.isNotification,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Badge(
                        elevation: 0,
                        position: BadgePosition.topStart(start: 2, top: 0),
                        badgeColor: HexColor('#D4721B'),
                        child: SvgPicture.asset(
                            'assets/images/notificationwhtie.svg',
                            color: white,
                            height: 25.h,
                            width: 20.w),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 3.0,
                      shadowColor: black,
                      child: TextField(
                        controller: searchController,
                        cursorColor: mainColor,
                        decoration: InputDecoration(
                          hintText: 'searchmedicine'.tr,
                          isDense: true,
                          filled: true,
                          fillColor: white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: Icon(
                            Icons.tune_rounded,
                            color: HexColor('#196737'),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
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
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(134.h),
    );
  }
}
