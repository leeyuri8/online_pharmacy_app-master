import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Category/MedicationsCard.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Medicines/PharmMedicineDetails.dart';
import 'package:drug_delivery_application/screens/user/Medications/Card/MedicationsCard.dart';
import 'package:drug_delivery_application/screens/user/Medications/MedicationsDetails/MedicationsDetails.dart';
import 'package:drug_delivery_application/screens/user/Medications/appBar/AppBars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helpers/theme.dart';


class PharmMedications extends StatefulWidget {
  final String cateid;
  final String cateName;

  const PharmMedications({Key? key, required this.cateid, required this.cateName}) : super(key: key);
  
 

  @override
  State<PharmMedications> createState() => _PharmMedicationssState();
}

class _PharmMedicationssState extends State<PharmMedications> {
     User? user = FirebaseAuth.instance.currentUser;
     

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:StreamBuilder(
                stream: getPharmAllCategoriesMedications(widget.cateid, user!.uid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
               ?
      Scaffold(
        backgroundColor: white,
        appBar: AppBars(widget.cateName, true, 100, true, 83 ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 50.h),
          children: [
            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 33.h, left: 26.w, right: 26.w),
                              child: Text(
                                'Showing items ${snapshot.data!.size}',
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
                                    left: 20.w, right: 20.w, bottom: 40.h),
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
                                        Get.to(() => PharmMedicationsDetails(
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
                                              //      snapshot.data!
                                              // .docs[index]['categoryName']
                                              // .toString(),
                                              //   snapshot.data!
                                              // .docs[index]['pharmName']
                                              // .toString(),
                                            ));
                                      },
                                      child: PharmMedicationsCard(
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
                                            snapshot.data!.docs[index]['categoryName']
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
                           
                          ],
                        )]
        )
      ): Text('');
                  
                })
    );   
  }
}
