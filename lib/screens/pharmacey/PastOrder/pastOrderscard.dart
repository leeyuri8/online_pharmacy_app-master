import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PastOrderscard extends StatefulWidget {
  final String OrderStatus;
  final List items;
  final String orderNum;
  final String date;

  PastOrderscard(this.OrderStatus, this.items, this.orderNum,this.date, {Key? key}) : super(key: key);

  @override
  _PastOrderscardState createState() => _PastOrderscardState();
}

class _PastOrderscardState extends State<PastOrderscard> {
  
  bool clor = false;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 29.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: 28.w,
            right: 23.w,
          ),
          width: 359.w,
          height: 127.h,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(color: bordergrey, width: .5.w),
            borderRadius: BorderRadius.circular(13.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        clor != clor;
                      });
                    },
                    child: clor == false
                        ? Container(
                            width: 84.w,
                            height: 26.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.r),
                              color: lightgreen,
                            ),
                            child: Center(
                              child: Text(
                                 'deliverd'.tr,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: green,
                                    fontFamily: montserratBold,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Container(
                            width: 84.w,
                            height: 26.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.r),
                              color: red,
                            ),
                            child: Center(
                              child: Text(
                                'canceled'.tr,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: montserratBold,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: montserratBold,
                      color: bordergrey,
                    ),
                  )
                ],
              ),
              Text(
               '${'order'.tr} ${widget.orderNum}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: montserratBold,
                  color: black2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 167.w,
                child: Text(
                 '${widget.items.length} ${'items'.tr}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: poppins,
                    color: lightgrey1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
