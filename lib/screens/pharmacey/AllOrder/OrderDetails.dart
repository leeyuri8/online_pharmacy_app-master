import 'package:drug_delivery_application/backend/AppGet.dart';
import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/user/Medications/appBar/AppBars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Inventory/Medicines/PharmMedicineDetails.dart';
import 'OrderDetailsCard.dart';

class OrderDetailsPage extends StatefulWidget {
 final String orderNum;
 final List items;
 
  
  OrderDetailsPage( this.orderNum, this.items
  ,{Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final AppGet orders = Get.put(AppGet());

  User? user = FirebaseAuth.instance.currentUser;
  var snapshot;

   @override
void initState() {
    super.initState();
      totalAmountPharm();
}
   totalAmountPharm() {
    appGet.priceOrder.value = 0.0;
    appGet.orderTotalPrice.value = 0.0;
    
    for (int i = 0; i < widget.items.length; i++) {
      appGet.priceOrder.value += double.parse( widget.items[i]['medicinePrice']) *
          double.parse( widget.items[i]['quntity']);
    }
    appGet.orderTotalPrice.value += appGet.priceOrder.value;
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: white,
        appBar: AppBars("orderdetails".tr, false, 75, true, 70),

        body: ListView(
          padding: const EdgeInsets.all(20),
            children: <Widget>[ 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Container(
                    width: 145.w,
                    height: 26.h,
                 alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: lightgreen,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                 child: Text(
                        'neworderrequest'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          
                          fontFamily: montserratBold,
                          color: mainColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                   ),
                  //  Text('${widget.items.length} items',
                  //           style: TextStyle(
                  //               fontSize: 14.sp,
                  //               fontFamily: montserratBold,
                  //               color: HexColor('#393939'))),
                    Text(
               "${'order'.tr} ${widget.orderNum}",
                    style: const TextStyle(
                      fontWeight:FontWeight.w700,

                    ),)

                ],
              ),
              Container(
            height: 1.h,
            margin: EdgeInsets.only(top: 23.h, bottom: 10),
            width: double.infinity,
            color: HexColor('#CECECE'),
          ),

               
        widget.items.isNotEmpty
         ?
          Container (  
            // height: 700,
          child:ListView.builder(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                    return Column(
                       mainAxisSize: MainAxisSize.min,
                   children: [
                   OrderDetailsCard(
                    widget.items,
                   widget.items[index]['medicineName'].toString(),
                   widget.items[index]['medicinePrice'].toString(),
                   widget.items[index]['medicineImage'].toString(),
                   widget.items[index]['quntity'].toString(),
                   widget.items[index]['categoryId'].toString(),
                   widget.items[index]['categoryName'].toString(),
                   widget.items[index]['createdDate'].toString(),
                   widget.items[index]['medicineAvailability'].toString(),
                   widget.items[index]['medicineHowToUse'].toString(),
                   widget.items[index]['medicineDescription'].toString(),
                   widget.items[index]['pharmName'].toString(),
                   widget.items[index]['pharmaceyId'].toString(),
                   widget.items[index]['userId'].toString(),
                   widget.items[index]['totalPrice'].toString(),
                   widget.items[index]['medicineId'].toString(),
                  ), 
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    height: 1.h,
                    color: HexColor('#D1D1D1'),
                    ),

                              ]
                    );
                },
          )
          ) :Text('jyyj'),
          
         
          SizedBox(height: 15.h, width: 15.w,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("checkouttotal".tr, style: TextStyle(fontWeight: FontWeight.bold),),
             Text('${appGet.orderTotalPrice.value} ₪' , style: TextStyle(fontSize: 15),),
            ],
          ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 120.w,
                  height: 50.h,
                child: TextButton(
                  onPressed: () { 
                    //   sendTofcm('success'.tr,'confirmed'.tr,appGet.id,widget.orderNum);
                       updateOrderStatus(4, widget.orderNum);
                       
                   },
                  style: TextButton.styleFrom(backgroundColor: mainColor),
                  // height: 50.h,
                  // minWidth: 50.w,
                  child: Text("acceptall".tr, style: TextStyle(fontSize: 15.sp, color: white),
              
                ),
               
              )),
           SizedBox(height: 10.h,)   ,

              Container(
              width: 120.w,
               height: 50.h,
                child: TextButton(     
                 onPressed: (){}, 
                child: Text("rejectorder".tr, style: TextStyle(fontSize: 15.sp, color: white),),
                style: TextButton.styleFrom(backgroundColor: mainColor),
               
                ),
              )
            ],
           )
              
        
              
            ],

        ),
    
    );
  }
}