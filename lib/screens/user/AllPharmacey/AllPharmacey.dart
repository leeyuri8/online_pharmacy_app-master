import 'package:drug_delivery_application/screens/user/AllPharmacey/AllPharmaceyCard/AllPharmacyCard.dart';
import 'package:drug_delivery_application/screens/user/AllPharmacey/PharmaceyDetails/PharmaceyDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../backend/firebase.dart';
import '../../../helpers/theme.dart';
import '../Medications/appBar/AppBars.dart';

class AllPharmacey extends StatefulWidget {
  AllPharmacey({Key? key}) : super(key: key);

  @override
  State<AllPharmacey> createState() => _AllPharmaceyState();
}

class _AllPharmaceyState extends State<AllPharmacey> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBars('allpharm'.tr, false, 93, true, 80),
        body: Scaffold(
            body: ListView(
          padding: EdgeInsets.only(bottom: 50.h),
          children: [
            StreamBuilder(
                stream: getAllPharmacies(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 37.h, left: 21.w, right: 21.w),
                              child: Text(
                                '${'showing'.tr} ${snapshot.data!.size} ${'pharmacies'.tr}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: lightGrey,
                                    fontFamily: montserratBold,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.to(() => PharmaceyDetails(
                                            snapshot.data!.docs[index]['userId']
                                                .toString(),
                                            snapshot
                                                .data!.docs[index]['pharmName']
                                                .toString(),
                                            snapshot
                                                .data!.docs[index]['imageUrl']
                                                .toString(),
                                            snapshot
                                                .data!.docs[index]['address']
                                                .toString(),
                                            snapshot.data!
                                                .docs[index]['phoneNumber']
                                                .toString(),
                                            snapshot
                                                .data!.docs[index]['openHours']
                                                .toString(),
                                            snapshot.data!.docs[index]
                                                ['rating'],
                                          ));
                                    },
                                    child: AllPharmceycard(
                                      snapshot.data!.docs[index]['userId']
                                          .toString(),
                                      snapshot.data!.docs[index]['pharmName']
                                          .toString(),
                                      snapshot.data!.docs[index]['imageUrl']
                                          .toString(),
                                      snapshot.data!.docs[index]['address']
                                          .toString(),
                                      snapshot.data!.docs[index]['phoneNumber']
                                          .toString(),
                                      snapshot.data!.docs[index]['openHours']
                                          .toString(),
                                    ));
                              },
                            )
                          ],
                        )
                      : Text('');
                }),
          ],
        )),
      ),
    );
  }
}
