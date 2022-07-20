import 'package:drug_delivery_application/screens/user/HomePage/cards/categoriesCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../backend/firebase.dart';
import '../../../helpers/theme.dart';
import '../Medications/Medications.dart';
import '../Medications/appBar/AppBars.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBars('allcate'.tr, false, 93, true, 90),
          body: ListView(
            padding: EdgeInsets.only(bottom: 50.h),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 33.h, left: 26.w, right: 26.w),
                child: Text(
                  'allcate'.tr,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: mainColor,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: StreamBuilder(
                      stream: getAllCategories(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return snapshot.hasData
                            ? GridView.builder(
                                padding:
                                    EdgeInsets.only(left: 20.w, right: 20.w),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 50),
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(() => Medications(snapshot
                                            .data!.docs[index]['catId']
                                            .toString(),
                                            false,'' 
                                            ));
                                      },
                                      child: CategoriesCard(
                                        snapshot.data!.docs[index]['catId']
                                            .toString(),
                                        snapshot.data!.docs[index]['catName']
                                            .toString(),
                                        snapshot.data!.docs[index]['catImage']
                                            .toString(),
                                      ));
                                },
                              )
                            : Text('');
                      }))
            ],
          )),
    );
  }
}
