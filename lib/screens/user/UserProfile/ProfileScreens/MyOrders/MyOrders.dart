import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../backend/firebase.dart';
import '../../../Medications/appBar/AppBars.dart';
import 'MyOrdersCard.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
    // getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBars('myorders'.tr, false, 93, true, 98),
        body: StreamBuilder(
            stream: getUserOrders(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      padding: EdgeInsets.only(bottom: 50.h),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return MyOrdersCard(
                            snapshot.data!.docs[index]['address'].toString(),
                            snapshot.data!.docs[index]['note'].toString(),
                            snapshot.data!.docs[index]['orderNumber']
                                .toString(),
                            snapshot.data!.docs[index]['orderStatus']
                                .toString(),
                            snapshot.data!.docs[index]['phamName'].toString(),
                            snapshot.data!.docs[index]['pharmId'].toString(),
                            snapshot.data!.docs[index]['items'],
                            // snapshot.data!.docs[index]['deliveryDate'].toString(),
                            DateTime.fromMicrosecondsSinceEpoch(snapshot
                                            .data!.docs[index]['deliveryDate'] *
                                        1000)
                                    .day
                                    .toString() +
                                ' ' +
                                DateTime.fromMicrosecondsSinceEpoch(snapshot
                                            .data!.docs[index]['deliveryDate'] *
                                        1000)
                                    .month
                                    .toString() +
                                ' ' +
                                DateTime.fromMicrosecondsSinceEpoch(snapshot
                                            .data!.docs[index]['deliveryDate'] *
                                        1000)
                                    .year
                                    .toString());
                       },
                    )
                  : Text('');
            }),
      ),
    );
  }
}
