import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../helpers/theme.dart';
import '../../../Medications/appBar/AppBars.dart';
import 'FavoriteCard.dart';

class Favourite extends StatefulWidget {
  Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars('favourite'.tr, false, 93, true, 98),
      body: Obx(
        () => appGet.favList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 50.h),
                itemCount: appGet.favList.length,
                itemBuilder: (context, index) {
                  return FavoriteCard(
                      appGet.favList[index]['medicineId'].toString(),
                      appGet.favList[index]['medicineName'].toString(),
                      appGet.favList[index]['medicineImage'].toString(),
                      appGet.favList[index]['medicinePrice'].toString(),
                      appGet.favList[index]['medicineDescription'].toString(),
                      appGet.favList[index]['categoryId'].toString(),
                      appGet.favList[index]['medicineAvailability'].toString(),
                      appGet.favList[index]['medicineHowToUse'].toString(),
                      appGet.favList[index]['pharmaceyId'].toString(),
                      appGet.favList[index]['categoryName'].toString(),
                      appGet.favList[index]['pharmName'].toString());
                },
              )
            : Center(
              child: Text(
                  'favempty'.tr,
                  style: TextStyle(
                      color: black1,
                      fontSize: 14.sp,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w600),
                ),
            ),
      ),
    );
  }
}
