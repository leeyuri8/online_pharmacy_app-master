import 'package:drug_delivery_application/screens/user/Medications/Card/MedicationsCard.dart';
import 'package:drug_delivery_application/screens/user/Medications/MedicationsDetails/MedicationsDetails.dart';
import 'package:drug_delivery_application/screens/user/Medications/appBar/AppBars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../backend/firebase.dart';
import '../../../helpers/theme.dart';

class Medications extends StatefulWidget {
  final String cateid;
  final bool isPharm;
  final String pharmId;

  Medications(this.cateid, this.isPharm, this.pharmId, {Key? key})
      : super(key: key);

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBars('medication'.tr, false, 93, true, 98),
        // AppBars('', true, 134, false, 90),
        body: ListView(
          padding: EdgeInsets.only(bottom: 50.h),
          children: [
            StreamBuilder(
                stream: widget.isPharm
                    ? getAllCategoriesMedicationsByPharm(
                        widget.cateid, widget.pharmId)
                    : getAllCategoriesMedications(widget.cateid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 33.h, left: 26.w, right: 26.w),
                              child: Text(
                                '${'showitem'.tr} ${snapshot.data!.size}',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: lightGrey,
                                    fontFamily: montserratBold,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.h),
                              child: GridView.builder(
                                padding: EdgeInsets.only(
                                    left: 20.w, right: 20.w, bottom: 50.h),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 22),
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(() => MedicationsDetails(
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
                                            ));
                                      },
                                      child: MedicationsCard(
                                        snapshot.data!.docs[index]['medicineId']
                                            .toString(),
                                        snapshot
                                            .data!.docs[index]['medicineName']
                                            .toString(),
                                        snapshot
                                            .data!.docs[index]['medicineImage']
                                            .toString(),
                                        snapshot
                                            .data!.docs[index]['medicinePrice']
                                            .toString(),
                                        snapshot.data!
                                            .docs[index]['medicineDescription']
                                            .toString(),
                                        snapshot.data!.docs[index]['categoryId']
                                            .toString(),
                                        snapshot.data!
                                            .docs[index]['medicineAvailability']
                                            .toString(),
                                        snapshot.data!
                                            .docs[index]['medicineHowToUse']
                                            .toString(),
                                        snapshot
                                            .data!.docs[index]['pharmaceyId']
                                            .toString(),
                                      ));
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        )
                      : Text('');
                })
          ],
        ),
      ),
    );
  }
}
