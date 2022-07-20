import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Category/PharmMedication.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Category/pharmcategoriesCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../backend/firebase.dart';

class PharmCategories extends StatefulWidget {
   

  PharmCategories({Key? key,}) : super(key: key);
  @override
  State<PharmCategories> createState() => _PharmCategoriesState();
}

class _PharmCategoriesState extends State<PharmCategories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //  appBar: const CustomAppbar(false),
          body: ListView(
        padding: EdgeInsets.only(bottom: 40.h),
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 35.h, left: 26.w, right: 26.w, bottom: 33.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'allcate'.tr,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: mainColor,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w800),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text("edit".tr,
                  //         style: TextStyle(
                  //             color: mainColor, fontWeight: FontWeight.bold)),
                  //     SizedBox(
                  //       width: 5.w,
                  //     ),
                  //     Icon(
                  //       Icons.edit_note_sharp,
                  //       color: mainColor,
                  //     )
                  //   ],
                  // )
                ]),
          ),
          Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: StreamBuilder(
                  stream: getAllCategories(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? 
                        
                        GridView.builder(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 30),
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                      Get.to(() => PharmMedications(key: Key('j'), cateid: snapshot.data!.docs[index]['catId']
                                        .toString(), cateName:  snapshot.data!.docs[index]['catName']
                                        .toString(), ));
                                  },
                                  child: PharmCategoriesCard(
                                    snapshot.data!.docs[index]['catId']
                                        .toString(),
                                    snapshot.data!.docs[index]['catName']
                                        .toString(),
                                    snapshot.data!.docs[index]['catImage']
                                        .toString(),
                             )
                                  );
                            },
                          )
                        : Text('');
                  })
                  )
        ],
      )),
    );
  }
}
