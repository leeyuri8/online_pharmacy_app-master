import 'package:drug_delivery_application/backend/AppGet.dart';
import 'package:drug_delivery_application/screens/user/Cart/Cards/CartCard.dart';
import 'package:drug_delivery_application/screens/user/Cart/ChangeAddress/ChangeAddress.dart';
import 'package:drug_delivery_application/screens/user/Cart/checkout/Checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../backend/firebase.dart';
import '../../../helpers/theme.dart';
import '../Medications/appBar/AppBars.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final AppGet carts = Get.put(AppGet());

  @override
  void initState() {
    super.initState();
    getUserCart().then((value) {
      totalprice();
    });
  }

  totalprice() {
    appGet.price.value = 0.0;
    appGet.totatlPrice.value = 0.0;
    
    for (int i = 0; i < appGet.cartList.length; i++) {
      appGet.price.value += double.parse(appGet.cartList[i]['medicinePrice']) *
          double.parse(appGet.cartList[i]['quntity']);
    }
    appGet.totatlPrice.value += appGet.price.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 110.w,
                  ),
                  Text(
                    'mycart'.tr,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: white,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(93.h),
        ),
        body: Obx(
          () => Stack(
            children: [
              ListView(
                children: [
                  Container(
                      height: 50.h,
                      width: double.infinity,
                      color: lightGrey.withOpacity(0.5),
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/location.svg'),
                                SizedBox(width: 10.w),
                                Text(appGet.userMap['address'],
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontFamily: montserratBold,
                                        color: black)),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => ChangeAddress());
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_drop_down_outlined,
                                      color: black, size: 20.w),
                                  SizedBox(width: 5.w),
                                  Text('changeaddress'.tr,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: montserratBold,
                                          color: HexColor('#7089F0'))),
                                ],
                              ),
                            ),
                          ])),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.h, left: 25.w, right: 15.w),
                    child: Row(
                      children: [
                        Text('total'.tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: montserratBold,
                                color: black)),
                        SizedBox(width: 29.w),
                        Text('${appGet.cartList.length} items',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: montserratBold,
                                color: HexColor('#393939'))),
                        SizedBox(width: 90.w),
                        GestureDetector(
                          onTap: () {
                            deleteCart().then((value) {
                              appGet.cartList.clear();
                              Future.delayed(const Duration(seconds: 5), () {
                                getUserCart();
                              });
                            });
                          },
                          child: Container(
                            height: 31.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.w),
                                color: HexColor('#3D3E41')),
                            child: Center(
                                child: Text(
                              'clearcart'.tr,
                              style: TextStyle(
                                color: white,
                                fontSize: 13.sp,
                                fontFamily: montserratBold,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 22.h),
                    height: .5.h,
                    color: HexColor('#D1D1D1'),
                  ),
                  appGet.cartList.isNotEmpty
                      ?
                       ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: appGet.cartList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CartCard (
                                  appGet.cartList[index]['medicineId']
                                      .toString(),
                                  appGet.cartList[index]['medicineName']
                                      .toString(),
                                  appGet.cartList[index]['medicineImage']
                                      .toString(),
                                  appGet.cartList[index]['medicinePrice']
                                      .toString(),
                                  appGet.cartList[index]['medicineDescription']
                                      .toString(),
                                  appGet.cartList[index]['categoryId']
                                      .toString(),
                                  appGet.cartList[index]['medicineAvailability']
                                      .toString(),
                                  appGet.cartList[index]['medicineHowToUse']
                                      .toString(),
                                  appGet.cartList[index]['pharmaceyId']
                                      .toString(),
                                  appGet.cartList[index]['totalPrice']
                                      .toString(),
                                  appGet.cartList[index]['quntity']
                                  .toString(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  height: 1.h,
                                  color: HexColor('#D1D1D1'),
                                ),
                              ],
                            );
                          },
                        )
                      : Text(""),
                ],
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  height: 63.h,
                  width: 330.w,
                  color: lightGrey.withOpacity(0.5),
                  margin: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'checkouttotal'.tr,
                        style: TextStyle(
                          color: black1,
                          fontSize: 14.sp,
                          fontFamily: montserratBold,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (appGet.cartList.isEmpty) {
                          } else {
                            getUserCart().then((value) {
                              totalprice();
                            });
                            Get.to(() => CheckOut());
                          }
                        },
                        child: Container(
                            height: 50.h,
                            width: 167.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: mainColor),
                            child: Center(
                                child: Text(
                              'checkout'.tr,
                              style: TextStyle(
                                color: white,
                                fontSize: 14.sp,
                                fontFamily: poppins,
                              ),
                            ))),
                      ),
                      Text(
                        '${appGet.totatlPrice.value}₪',
                        style: TextStyle(
                          color: black1,
                          fontSize: 14.sp,
                          fontFamily: poppins,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
