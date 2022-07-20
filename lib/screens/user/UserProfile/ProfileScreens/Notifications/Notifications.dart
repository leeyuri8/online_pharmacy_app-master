import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../../../../backend/firebase.dart';
import '../../../Medications/appBar/AppBars.dart';
import 'NotificationsCard.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List _elements = [
    {'name': 'John', 'group': 'Today'},
    {'name': 'Beth', 'group': 'Yesterday'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBars('notifications'.tr, false, 93, true, 98),
        body:
            // GroupedListView<dynamic, String>(
            //   elements: _elements,
            //   groupBy: (element) => element['group'],
            //   groupSeparatorBuilder: (String groupByValue) => Padding(
            //     padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
            //     child: Text(
            //       groupByValue,
            //       style: TextStyle(
            //           fontSize: 14.sp,
            //           fontWeight: FontWeight.w600,
            //           color: black,
            //           fontFamily: poppins),
            //     ),
            //   ),
            //   itemBuilder: (context, dynamic element) => NotificationsCard(),
            //   itemComparator: (item1, item2) =>
            //       item1['name'].compareTo(item2['name']),
            //   useStickyGroupSeparators: false,
            //   floatingHeader: false,
            //   order: GroupedListOrder.ASC,
            // ),

            StreamBuilder(
                stream: getNotificationsStream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: EdgeInsets.only(bottom: 50.h),
                          itemCount: snapshot.data.size,
                          itemBuilder: (context, index) {
                            return NotificationsCard(
                              snapshot.data.docs[index].data()['datecreate'],
                              snapshot.data.docs[index].data()['title'],
                              snapshot.data.docs[index].data()['fcmorder'],
                              snapshot.data.docs[index].data()['status'],
                              snapshot.data.docs[index].data()['userId'],
                              snapshot.data.docs[index].data()['body'],
                            );
                          },
                        )
                      : Text('');
                }),
      ),
    );
  }
}
