import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../backend/firebase.dart';
import '../../../../helpers/theme.dart';
import '../../Medications/appBar/AppBars.dart';

class RateUs extends StatefulWidget {
  RateUs({Key? key}) : super(key: key);

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;
  late double _rating;

  IconData? _selectedIcon;

  TextEditingController ratecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBars('rateus'.tr, false, 93, true, 105),
          body: ListView(
            children: [
              // SizedBox(height: 160.h),
              // Container(
              //   height: 235.h,
              //   width: 215.w,
              //   margin: EdgeInsets.only(left: 80.w, right: 80.w),
              //   decoration: BoxDecoration(
              //       color: white,
              //       borderRadius: BorderRadius.circular(20.w),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.1),
              //           spreadRadius: .01,
              //           blurRadius: 5,
              //         )
              //       ]),
              // child:
              SizedBox(height: 41.h),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Text(
                  'enjoy'.tr,
                  style: TextStyle(
                    color: mainGreen,
                    fontSize: 20.sp,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 17.h),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Text(
                  'writereviwe'.tr,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mainGreen,
                    fontSize: 14.sp,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: TextField(
                      controller: ratecontroller,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        labelText: 'yourreview'.tr,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: lightGrey2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: lightGrey2),
                        ),
                        labelStyle: TextStyle(
                            color: lightGrey,
                            fontSize: 14.sp,
                            fontFamily: montserratBold),
                      ),
                    )),
              ),
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: _initialRating,
                  minRating: 1,
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 30.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: HexColor('#FFB238'),
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                  updateOnDrag: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (ratecontroller.text.isEmpty) {
                    EasyLoading.showError('pleasereview'.tr);
                  } else if (_rating == 0.0) {
                    EasyLoading.showError('pleaserate'.tr);
                  } else {
                    EasyLoading.show(status: 'loading'.tr);
                    userReview(ratecontroller.text.toString(), _rating)
                        .then((value) {
                      EasyLoading.dismiss();
                      if (value == true) {
                        EasyLoading.showSuccess('addedsucce'.tr);
                      }
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 70.h),
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50.h,
                        width: 274.w,
                        child: Center(
                          child: Text(
                            'submit'.tr,
                            style: TextStyle(
                                color: white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: montserratBold),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(21)),
                      )),
                ),
              ),
              // )
            ],
          )),
    );
  }
}
