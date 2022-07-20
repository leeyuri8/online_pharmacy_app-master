import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/pharmacey/PastOrder/pastOrderscard.dart';
import 'package:drug_delivery_application/screens/user/Medications/appBar/AppBars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PastOrders extends StatefulWidget {
  PastOrders({Key? key}) : super(key: key);

  @override
  _PastOrdersState createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
     User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBars('pastorders'.tr, false, 93.h, true, 65.w),

        body: StreamBuilder(
         stream: pastOrders(user!.uid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData 
                  ?
                  ListView.builder(
          itemCount: snapshot.data!.size,
          itemBuilder: (BuildContext context, int index) {
            
            return Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),

              child: PastOrderscard(
              snapshot.data!.docs[index]['orderStatus'].toString(),
              snapshot.data!.docs[index]['items'],
              snapshot.data!.docs[index]['orderNumber'].toString(),
            //  snapshot.data.docs[index]['deliveryDate'].toString(),
    
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
             
              ),
            );
          },
        ):Text('jj');
     }
      ),
    ));
  }
}
