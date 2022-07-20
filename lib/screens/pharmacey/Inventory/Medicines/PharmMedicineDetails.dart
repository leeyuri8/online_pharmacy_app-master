import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/utile.dart';
import 'package:drug_delivery_application/screens/user/Medications/Card/RelatedProductsCard.dart';
import 'package:drug_delivery_application/screens/user/Medications/appBar/AppBars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../helpers/Counter.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/theme.dart';

class PharmMedicationsDetails extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;
  final String categoryId;
  final String avalibilty;
  final String howToUse;
  final String pharmId;
  // final String categroyName;
  // final String pharmName;

  const PharmMedicationsDetails(
      this.id,
      this.name,
      this.image,
      this.price,
      this.description,
      this.categoryId,
      this.avalibilty,
      this.howToUse,
      this.pharmId,
      // this.categroyName,
      // this.pharmName,
      {Key? key})
      : super(key: key);

  @override
  State<PharmMedicationsDetails> createState() => _PharmMedicationsDetailsState();
}

class _PharmMedicationsDetailsState extends State<PharmMedicationsDetails> {
  var snapshot;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBars('details'.tr, false, 93, true, 100),
        body: ListView(padding: EdgeInsets.only(bottom: 50.h), children: [
          Container(
              height: 266.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: white,
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [white, HexColor('#E2F6E5')]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 29.h, right: 20.w, left: 20.w),
                      height: 25.h,
                      width: 25.w,
                     
                      // child: Center(
                      //     child: Icon(Icons.edit_note_sharp,
                      //         size: 30, color: mainColor)),
                    ),
                  ),
                Center(
              child:  ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: WidgetRelease.getInstance().cashed(
              widget.image,
              130,
              141,
            ),
          ),
                )  ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
              widget.name,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: HexColor('#393939'),
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w800),
            ),
           
            ]
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 13.h, left: 20.w, right: 20.w),
            child: Text(
                '₪ ${widget.price}'.tr,
              style: TextStyle(
                  color: HexColor('#196737'),
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: montserratBold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 13.h, left: 20.w, right: 20.w),
            child: Row(
              children: [
                Text(
                  'availabilty'.tr,
                  style: TextStyle(
                      color: grey2,
                      fontSize: 16.sp,
                      fontFamily: montserratBold),
                ),
                Text(
                   widget.avalibilty == '1' ? 'instock'.tr : 'outstock'.tr,
                  style: TextStyle(
                      color: HexColor('#196737'),
                      fontSize: 14.sp,
                      fontFamily: montserratBold),
                ),
              ],
            ),
          ),
      
          Padding(
            padding: EdgeInsets.only(top: 22.h, left: 20.w, right: 20.w),
            child: Text(
              'description'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: mainGreen,
                  fontFamily: montserratBold,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 11.h, left: 20.w, right: 20.w),
            child: Text(
              widget.description
             , style: TextStyle(
                  fontSize: 16.sp,
                  color: HexColor('#626262'),
                  fontFamily: montserratBold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35.h, left: 20.w, right: 20.w),
            child: Text(
              'howtouse'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                   color: mainGreen,
                  fontFamily: montserratBold,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 11.h, left: 20.w, right: 20.w),
            child: Text(
              widget.howToUse.tr,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: HexColor('#626262'),
                  fontFamily: montserratBold),
            ),
          ),
          Container(
            height: 1.h,
            margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
            width: double.infinity,
            color: HexColor('#CECECE'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 17.h, left: 20.w, right: 20.w),
            child: Text(
              'relatedpro'.tr,
               style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: mainGreen,
                  fontFamily: montserratBold),
            ),
          ),
           SizedBox(height: 10.h),
          SizedBox(
            height: 130.h,
            child: StreamBuilder(
                stream: getPharmAllCategoriesMedications(widget.categoryId, widget.pharmId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ?
                       ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:snapshot.data!.size > 3 ? 3 : snapshot.data!.size,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PharmMedicationsDetails(
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
                                          
                                            )
                                            )
                                            );
                              },
                              child: RelatedCard( 
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
                                 
                              ),
                            );
                          },
                        )
                      : Text('');
                }),
          )
        ]),
      ),
    );
  }
}
