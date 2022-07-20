import 'package:badges/badges.dart';
import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/pharmacey/AllOrder/OrderDetails.dart';
import 'package:drug_delivery_application/screens/user/UserProfile/ProfileScreens/Notifications/Notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'AllOrdersCard.dart';

class DrugDelieveryscr extends StatefulWidget {
  DrugDelieveryscr({Key? key}) : super(key: key);

  @override
  _DrugDelieveryscrState createState() => _DrugDelieveryscrState();
}

class _DrugDelieveryscrState extends State<DrugDelieveryscr> {
     User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(98.h),
          child: Container(
            height: 98.h,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                border: Border.all(color: grey2),
                color: mainColor),
            child: Padding(
              padding: EdgeInsets.only(
                // top: 60.h,
                right: 15.w,
                left: 15.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                     'drugdelivery'.tr,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: poppins,
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   InkWell(
                  onTap: () {
                    Get.to(() => Notifications());
                  },
                  child: Badge(
                      showBadge:
                          appGet.notificationcounts.string.toString().isNotEmpty
                              ? true
                              : false,
                      badgeColor: HexColor('#D4721B'),
                      elevation: 0,
                      position: BadgePosition.topStart(start: 8, top: 2),
                      child:
                      Icon(
                      Icons.notifications_rounded,
                      color: white,
                      size: 30,
                    ),            
                        ),
              )],
              ),
            ),
          ),
        ),

        body: StreamBuilder(
            stream: getAllorders(user!.uid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
             return snapshot.hasData
                        ? 
     
         ListView.builder(
          itemCount:snapshot.data!.size,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Get.to(() => OrderDetailsPage(
                     snapshot.data!.docs[index]['orderNumber'] .toString(),   
                     snapshot.data!.docs[index]['items']   
                    ));
                },
                child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      right: 8.w,
                    ),

            child: AllOederCard(
                snapshot.data!.docs[index]['orderNumber'] .toString(),
                snapshot.data!.docs[index]['address'].toString(),
                        
             '${DateTime.fromMicrosecondsSinceEpoch(snapshot
                    .data!.docs[index]['deliveryDate'] *
                1000) 
            .day} ${DateTime.fromMicrosecondsSinceEpoch(snapshot
                    .data!.docs[index]['deliveryDate'] *
                1000)
            .month} ${DateTime.fromMicrosecondsSinceEpoch(snapshot
                    .data!.docs[index]['deliveryDate'] *
                1000)
            .year}',                       
            snapshot.data!.docs[index]['pharmId'].toString(),
            snapshot.data!.docs[index]['items'],
            snapshot.data!.docs[index]['orderStatus'].toString(),
            snapshot.data!.docs[index]['note'].toString(),
                    )
                    ));
            }): Text('There is no orders yet' , style: TextStyle(fontSize: 20.sp), textAlign: TextAlign.center,);
            }
            )
            ),);
  }}

                    


