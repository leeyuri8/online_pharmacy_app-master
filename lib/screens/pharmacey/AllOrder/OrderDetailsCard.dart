import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/helpers/utile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';


class OrderDetailsCard extends StatefulWidget {
  final List items;
  final String productName;
  final String productPrice;
  final String productImage;
  final String quntity;
  final String catId;
  final String catName;
  final String date;
  final String medicineAvailability;
  final String howToUse;
  final String medDes;
  final String pharmName;
  final String pharmId;
  final String userId;
  final String totalPrice;
  final String medId;

  

   OrderDetailsCard( this.items ,this.productName, this.productPrice, this.productImage, this.quntity ,  this.catId,  this.catName,  this.date,  this.medicineAvailability,  this.howToUse,  this.medDes,  this.pharmName,  this.pharmId,  this.userId,  this.totalPrice,  this.medId,{Key? key}) : super(key: key);

  @override
  State<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
    int qtty = 0;
  late double totalPrice;
  @override
  void initState() {
    super.initState();
    qtty = int.parse(widget.quntity);
    totalPrice = double.parse(widget.totalPrice);
  }

    totalprice() {
    appGet.priceOrder.value = 0.0;
    appGet.orderTotalPrice.value = 0.0;
    for (int i = 0; i < widget.items.length; i++) {
      appGet.priceOrder.value +=
          double.parse(widget.items[i]['medicinePrice']) * qtty;
    }
    appGet.orderTotalPrice.value += appGet.priceOrder.value;
  }
    bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  <Widget>[

         Checkbox(
          tristate: true,
          value: this.value,
        
          shape: CircleBorder(),
          activeColor: mainColor,
          onChanged: (val){
            setState(() {
              value = val;
            });
          }
          ),

        Container(
             width: 60,
             height: 60,
         child:   ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: WidgetRelease.getInstance().cashed(
              widget.productImage,
              80,
              141,
            ),
          ),
             ),

             Column(
              children:[
              Text(widget.productName, style: TextStyle(color: grey, fontSize: 16, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${widget.productPrice} ₪' , style: TextStyle(fontSize: 15),),
                  SizedBox(
                  height: 20,
                  width: 20,
                  ),
                  Container(
                              width: 18.w,
                              height: 18.h,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: bordergrey,
                                  )),
                              child: Text(widget.quntity, textAlign: TextAlign.center,)
                              ),
                            
                ],
              ),
           


              ]
             )
        ],
      ),

    );
  }
}

 isChecked() {
 
}