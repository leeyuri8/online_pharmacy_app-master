import 'package:drug_delivery_application/screens/user/Cart/checkout/Checkout.dart';
import 'package:drug_delivery_application/screens/user/Medications/Card/RelatedProductsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../backend/firebase.dart';
import '../../../../helpers/Counter.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/theme.dart';
import '../../../../helpers/utile.dart';
import '../appBar/AppBars.dart';

class MedicationsDetails extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;
  final String categoryId;
  final String avalibilty;
  final String howToUse;
  final String pharmId;
  final String categoryName;
  final String pharmName;
  const MedicationsDetails(
      this.id,
      this.name,
      this.image,
      this.price,
      this.description,
      this.categoryId,
      this.avalibilty,
      this.howToUse,
      this.pharmId,
      this.categoryName,
      this.pharmName,
      {Key? key})
      : super(key: key);

  @override
  State<MedicationsDetails> createState() => _MedicationsDetailsState();
}

class _MedicationsDetailsState extends State<MedicationsDetails> {
  bool isFav = false;
  @override
  void initState() {
    super.initState();
    checkCartItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBars('details'.tr, false, 93, true, 110),
        body: ListView(padding: EdgeInsets.only(bottom: 50.h), children: [
          Container(
              height: 266.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: white,
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [white, HexColor('#E2F6E5')]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: WidgetRelease.getInstance().cashed(
                      widget.image,
                      266,
                      360,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFav = !isFav;
                        print(isFav);
                      });
                      if (isFav == true) {
                        addToFavourite(
                            widget.image.toString(),
                            widget.name.toString(),
                            widget.price.toString(),
                            widget.avalibilty.toString(),
                            widget.description.toString(),
                            widget.howToUse.toString(),
                            widget.categoryId.toString(),
                            widget.categoryName.toString(),
                            widget.id.toString(),
                            widget.pharmId.toString(),
                            widget.pharmName.toString());
                      } else {
                        removeFromFav(widget.id);
                      }
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 29.h, right: 20.w, left: 20.w),
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HexColor('#ffcccc'),
                        ),
                        child: Center(
                            child: Icon(Icons.favorite,
                                size: 15,
                                color: isFav == true
                                    ? HexColor('#F03A16')
                                    : grey)),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
            child: Text(
              widget.name,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: HexColor('#393939'),
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 13.h, left: 20.w, right: 20.w),
            child: Text(
              '₪${widget.price}',
              style: TextStyle(
                  color: HexColor('#196737'),
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: montserratBold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 13.h, left: 20.w, right: 20.w),
            child: Row(
              children: [
                Text(
                  '${'availabilty'.tr}: ',
                  style: TextStyle(
                      color: grey2,
                      fontSize: 16.sp,
                      fontFamily: montserratBold),
                ),
                Text(
                  widget.avalibilty == '1' ? 'instock'.tr : 'outstock'.tr,
                  style: TextStyle(
                      color: HexColor('#196737'),
                      fontSize: 16.sp,
                      fontFamily: montserratBold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 13.h, left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'selectqty'.tr,
                  style: TextStyle(
                      color: grey2,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: montserratBold),
                ),
                Counter(),
                // Row(
                //   children: [
                //     Container(
                //       width: 32.w,
                //       height: 32.h,
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
                //           fontSize: 17.sp,
                //           fontWeight: FontWeight.w600,
                //           fontFamily: montserratBold),
                //     ),
                //     SizedBox(width: 10.w),
                //     Container(
                //       width: 32.w,
                //       height: 32.h,
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h, left: 8.w, right: 8.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // if (appGet.pharmId == widget.pharmId) {

                    if (appGet.pharmId == '' ||
                        appGet.pharmId == widget.pharmId) {
                      //fiil
                      if (appGet.cartList.isEmpty) {
                        if (appGet.qty == 0) {
                          errorSanck(
                              widget.name, "addqty".tr, SnackPosition.TOP);
                        } else {
                          addToCart(
                            widget.image.toString(),
                            widget.name.toString(),
                            widget.price.toString(),
                            widget.avalibilty.toString(),
                            widget.description.toString(),
                            widget.howToUse.toString(),
                            widget.categoryId.toString(),
                            widget.categoryName.toString(),
                            appGet.qty.toString(),
                            widget.price.toString(),
                            widget.id.toString(),
                            widget.pharmId.toString(),
                            widget.pharmName.toString(),
                          ).then((value) {
                            if (value == true) {
                              successSanck(widget.name, "addedtocart".tr,
                                  SnackPosition.TOP);
                              getUserCart();
                            }
                          });
                        }
                      } else if (appGet.cartItemId == widget.id) {
                        print('kd');
                        errorSanck(
                            widget.name, "itemincart".tr, SnackPosition.TOP);
                      }
                    } else if (appGet.pharmId != widget.pharmId) {
                      //empty
                      samePharm(context);
                    }
                    // } else if (appGet.pharmId.value != widget.pharmId
                    //     appGet.pharmId.value != '') {
                    //   samePharm(context);
                    // }
                  },
                  child: Container(
                    height: 48.h,
                    width: 165.w,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        'addtocart'.tr,
                        style: TextStyle(
                            color: white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: montserratBold),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 7.w),
                GestureDetector(
                  onTap: () {
                    if (appGet.cartItemId == widget.id) {
                      errorSanck(
                          widget.name, "itemincart".tr, SnackPosition.TOP);
                    } else if (appGet.qty == 0) {
                      errorSanck(widget.name, "addqty".tr, SnackPosition.TOP);
                    } else {
                      addToCart(
                        widget.image.toString(),
                        widget.name.toString(),
                        widget.price.toString(),
                        widget.avalibilty.toString(),
                        widget.description.toString(),
                        widget.howToUse.toString(),
                        widget.categoryId.toString(),
                        widget.categoryName.toString(),
                        appGet.qty.toString(),
                        widget.price.toString(),
                        widget.id.toString(),
                        widget.pharmId.toString(),
                        widget.pharmName.toString(),
                      );
                      Get.to(() => CheckOut());
                    }
                  },
                  child: Container(
                    height: 48.h,
                    width: 165.w,
                    decoration: BoxDecoration(
                      color: HexColor('#F2F2F2'),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        'buynow'.tr,
                        style: TextStyle(
                            color: HexColor('#196737'),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: montserratBold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 22.h, left: 20.w, right: 20.w),
            child: Text(
              'description'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: HexColor('#393939'),
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 11.h, left: 20.w, right: 20.w),
            child: Text(
              '''${widget.description}''',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: HexColor('#626262'),
                  fontFamily: montserratBold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 45.h, left: 20.w, right: 20.w),
            child: Text(
              'howtouse'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: HexColor('#393939'),
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 11.h, left: 20.w, right: 20.w),
            child: Text(
              '''${widget.howToUse}''',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: HexColor('#626262'),
                  fontFamily: montserratBold),
            ),
          ),
          Container(
            height: 1.h,
            margin: EdgeInsets.only(top: 23.h, left: 20.w, right: 20.w),
            width: double.infinity,
            color: HexColor('#CECECE'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 17.h, left: 20.w, right: 20.w),
            child: Text(
              'relatedpro'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: HexColor('#393939'),
                  fontFamily: montserratBold),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 140.h,
            child: StreamBuilder(
                stream: getAllCategoriesMedications(widget.categoryId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              snapshot.data!.size > 3 ? 3 : snapshot.data!.size,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MedicationsDetails(
                                              snapshot.data!
                                                  .docs[index]['medicineId']
                                                  .toString(),
                                              snapshot.data!
                                                  .docs[index]['medicineName']
                                                  .toString(),
                                              snapshot.data!
                                                  .docs[index]['medicineImage']
                                                  .toString(),
                                              snapshot.data!
                                                  .docs[index]['medicinePrice']
                                                  .toString(),
                                              snapshot
                                                  .data!
                                                  .docs[index]
                                                      ['medicineDescription']
                                                  .toString(),
                                              snapshot.data!
                                                  .docs[index]['categoryId']
                                                  .toString(),
                                              snapshot
                                                  .data!
                                                  .docs[index]
                                                      ['medicineAvailability']
                                                  .toString(),
                                              snapshot
                                                  .data!
                                                  .docs[index]
                                                      ['medicineHowToUse']
                                                  .toString(),
                                              snapshot.data!
                                                  .docs[index]['pharmaceyId']
                                                  .toString(),
                                              snapshot.data!
                                                  .docs[index]['categoryName']
                                                  .toString(),
                                              snapshot.data!
                                                  .docs[index]['pharmName']
                                                  .toString(),
                                            )));
                              },
                              child: RelatedCard(
                                snapshot.data!.docs[index]['medicineId']
                                    .toString(),
                                snapshot.data!.docs[index]['medicineName']
                                    .toString(),
                                snapshot.data!.docs[index]['medicineImage']
                                    .toString(),
                                snapshot.data!.docs[index]['medicinePrice']
                                    .toString(),
                                snapshot
                                    .data!.docs[index]['medicineDescription']
                                    .toString(),
                                snapshot.data!.docs[index]['categoryId']
                                    .toString(),
                                snapshot
                                    .data!.docs[index]['medicineAvailability']
                                    .toString(),
                                snapshot.data!.docs[index]['medicineHowToUse']
                                    .toString(),
                                snapshot.data!.docs[index]['pharmaceyId']
                                    .toString(),
                                 
                              ),
                            );
                          },
                        )
                      : Text('');
                }),
          )
        ]),
      ),
    );
  }
}
