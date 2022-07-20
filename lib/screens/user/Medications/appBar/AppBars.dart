import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../backend/firebase.dart';
import '../../../../helpers/theme.dart';

class AppBars extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool visible;
  final double height;
  final bool isCenter;
  final double space;
  AppBars(this.title, this.visible, this.height, this.isCenter, this.space,
      {Key? key})
      : super(key: key);

  @override
  State<AppBars> createState() => _AppBarsState();

  @override
  Size get preferredSize => Size.fromHeight(height.h);
}

class _AppBarsState extends State<AppBars> {
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
            mainAxisAlignment: widget.isCenter
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          appGet.cartItemId = '';
                          appGet.qty = 0;
                        },
                        child: appGet.lanid == 'Arabic'
                            ? SvgPicture.asset(
                                'assets/images/ShapeFlip.svg',
                                color: white,
                                height: 16.h,
                                width: 25.w,
                              )
                            : SvgPicture.asset(
                                'assets/images/Shape.svg',
                                color: white,
                                height: 16.h,
                                width: 25.w,
                              ),
                      )),
                  SizedBox(
                    width: widget.space.w,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: white,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              // Visibility(
              //   visible: widget.visible,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              //     child: Align(
              //         alignment: Alignment.topLeft,
              //         child: Material(
              //           borderRadius: BorderRadius.circular(10),
              //           elevation: 3.0,
              //           shadowColor: black,
              //           child: TextField(
              //             cursorColor: mainColor,
              //             decoration: InputDecoration(
              //               hintText: 'Search medicine available.',
              //               isDense: true,
              //               filled: true,
              //               fillColor: white,
              //               enabledBorder: OutlineInputBorder(
              //                 borderSide: BorderSide(color: grey2),
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               suffixIcon: Icon(
              //                 Icons.tune_rounded,
              //                 color: HexColor('#196737'),
              //               ),
              //               focusedBorder: OutlineInputBorder(
              //                 borderSide:
              //                     const BorderSide(color: Colors.transparent),
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               hintStyle: TextStyle(
              //                   color: HexColor('#196737'),
              //                   fontSize: 14.sp,
              //                   fontFamily: montserratBold),
              //             ),
              //           ),
              //         )),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(widget.height.h),
    );
  }
}
