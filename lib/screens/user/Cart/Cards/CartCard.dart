import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../backend/firebase.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/theme.dart';
import '../../../../helpers/utile.dart';

class CartCard extends StatefulWidget {
  final String medid;
  final String medname;
  final String image;
  final String price;
  final String description;
  final String categoryId;
  final String avalibilty;
  final String howToUse;
  final String pharmId;
  final String total;
  final String qty;
  CartCard(
      this.medid,
      this.medname,
      this.image,
      this.price,
      this.description,
      this.categoryId,
      this.avalibilty,
      this.howToUse,
      this.pharmId,
      this.total,
      this.qty,
      {Key? key})
      : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int qtty = 0;
  late double totalPrice;
  @override
  void initState() {
    super.initState();
    qtty = int.parse(widget.qty);
    totalPrice = double.parse(widget.total);
  }

  void add() {
    setState(() {
      qtty++;
      totalprice();
      updateqty(qtty.toString(), widget.medid);
    });
  }

  void minus() {
    setState(() {
      if (qtty != 1) {
        qtty--;
        totalpriceM();
        updateqty(qtty.toString(), widget.medid);
      }
    });
  }

  totalprice() {
    appGet.price.value = 0.0;
    appGet.totatlPrice.value = 0.0;
    for (int i = 0; i < appGet.cartList.length; i++) {
      appGet.price.value +=
          double.parse(appGet.cartList[i]['medicinePrice']) * qtty;
    }
    appGet.totatlPrice.value += appGet.price.value;
  }

  totalpriceM() {
    appGet.price.value = 0.0;
    appGet.totatlPrice.value = 0.0;
    for (int i = 0; i < appGet.cartList.length; i++) {
      appGet.price.value -=
          double.parse(appGet.cartList[i]['medicinePrice']) * qtty;
    }
    appGet.totatlPrice.value -= appGet.price.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      child: Row(children: [
        SizedBox(width: 20.w),
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: HexColor('#D1D1D1'), width: 1.w),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: WidgetRelease.getInstance().cashed(
              widget.image,
              90,
              90,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    widget.medname,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.bold,
                        color: black1),
                  ),
                ),
                SizedBox(width: 80.w),
                InkWell(
                  onTap: () {
                    deleteCartItem(widget.medid).then((value) {
                      successSanck("Success", "deleted successfully",
                          SnackPosition.BOTTOM);
                      if (value == true) {
                        appGet.cartList.clear();
                        getUserCart();
                      }
                    });
                  },
                  child: SizedBox(
                      width: 20.w,
                      child: SvgPicture.asset('assets/images/rubbish-bin.svg')),
                ),
              ],
            ),
            SizedBox(
              width: 50.w,
              child: Text(
                widget.description,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: poppins,
                    color: HexColor('#626262')),
              ),
            ),
            Row(
              children: [
                Text(
                  '${widget.price}₪',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.bold,
                      color: black1),
                ),
                SizedBox(width: 80.w),
                SizedBox(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: minus,
                        child: Container(
                          width: 25.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: HexColor('#393939'),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.remove,
                                size: 15, color: HexColor('#393939')),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        qtty.toString(),
                        style: TextStyle(
                            color: HexColor('#393939'),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: poppins),
                      ),
                      SizedBox(width: 10.w),
                      GestureDetector(
                        onTap: () => add(),
                        child: Container(
                          width: 25.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: HexColor('#393939'),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.add,
                                size: 15, color: HexColor('#393939')),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
      ]),
    );
  }
}
