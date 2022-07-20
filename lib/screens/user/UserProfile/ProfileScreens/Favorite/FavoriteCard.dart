import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../backend/firebase.dart';
import '../../../../../helpers/Counter.dart';
import '../../../../../helpers/helper.dart';
import '../../../../../helpers/utile.dart';

class FavoriteCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;
  final String categoryId;
  final String avalibilty;
  final String howToUse;
  final String pharmId;
  final String catename;
  final String pharmname;
  FavoriteCard(
      this.id,
      this.name,
      this.image,
      this.price,
      this.description,
      this.categoryId,
      this.avalibilty,
      this.howToUse,
      this.pharmId,
      this.catename,
      this.pharmname,
      {Key? key})
      : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      margin: EdgeInsets.only(top: 40.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              children: [
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: HexColor('#D1D1D1'),
                      width: 1.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: WidgetRelease.getInstance().cashed(
                      widget.image,
                      100,
                      100,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 193.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                color: black1,
                                fontSize: 14.sp,
                                fontFamily: montserratBold,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${widget.price}₪',
                            style: TextStyle(
                                color: mainGreen,
                                fontSize: 12.sp,
                                fontFamily: montserratBold,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.description,
                      style: TextStyle(
                          color: HexColor('#B2B2B2'),
                          fontSize: 10.sp,
                          fontFamily: montserratBold),
                    ),
                    SizedBox(height: 33.h),
                    SizedBox(
                      width: 220.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Counter(),
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: 25.w,
                          //       height: 25.h,
                          //       decoration: BoxDecoration(
                          //         shape: BoxShape.rectangle,
                          //         color: white,
                          //         borderRadius: BorderRadius.circular(5),
                          //         border: Border.all(
                          //           color: HexColor('#393939'),
                          //           width: 1,
                          //         ),
                          //       ),
                          //       child: Center(
                          //         child: Icon(Icons.remove,
                          //             size: 15, color: HexColor('#393939')),
                          //       ),
                          //     ),
                          //     SizedBox(width: 10.w),
                          //     Text(
                          //       '1',
                          //       style: TextStyle(
                          //           color: HexColor('#393939'),
                          //           fontSize: 13.sp,
                          //           fontWeight: FontWeight.w600,
                          //           fontFamily: poppins),
                          //     ),
                          //     SizedBox(width: 10.w),
                          //     Container(
                          //       width: 25.w,
                          //       height: 25.h,
                          //       decoration: BoxDecoration(
                          //         shape: BoxShape.rectangle,
                          //         color: white,
                          //         borderRadius: BorderRadius.circular(5),
                          //         border: Border.all(
                          //           color: HexColor('#393939'),
                          //           width: 1,
                          //         ),
                          //       ),
                          //       child: Center(
                          //         child: Icon(Icons.add,
                          //             size: 15, color: HexColor('#393939')),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          GestureDetector(
                            onTap: () {
                              if (appGet.cartItemId == widget.id) {
                                errorSanck(widget.name, "itemincart".tr,
                                    SnackPosition.TOP);
                              } else if (appGet.qty == 0) {
                                errorSanck(widget.name, "addqty".tr,
                                    SnackPosition.TOP);
                              } else {
                                appGet.totalAmount(
                                    double.parse(widget.price), appGet.qty);
                                addToCart(
                                        widget.image.toString(),
                                        widget.name.toString(),
                                        widget.price.toString(),
                                        widget.avalibilty.toString(),
                                        widget.description.toString(),
                                        widget.howToUse.toString(),
                                        widget.categoryId.toString(),
                                        widget.catename.toString(),
                                        appGet.qty.toString(),
                                        appGet.total.toString(),
                                        widget.id.toString(),
                                        widget.pharmId.toString(),
                                        widget.pharmname)
                                    .then((value) {
                                  if (value == true) {
                                    successSanck(widget.name, "addedtocart".tr,
                                        SnackPosition.TOP);
                                  }
                                });
                              }
                            },
                            child: Container(
                                height: 27.h,
                                width: 86.w,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    'addtocart'.tr,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 12.sp,
                                        fontFamily: montserratBold),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            height: 1.h,
            color: HexColor('#D1D1D1'),
          )
        ],
      ),
    );
  }
}
