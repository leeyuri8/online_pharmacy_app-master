import 'package:drug_delivery_application/screens/user/FilterScreen/FilterCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../backend/firebase.dart';
import '../../../helpers/theme.dart';
import '../Medications/Card/MedicationsCard.dart';
import '../Medications/MedicationsDetails/MedicationsDetails.dart';
import 'CategoriesCard.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController _searchController = TextEditingController();
  late Future resultsLoaded;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getbyName();
  }

  _onSearchChanged() {
    appGet.all();
  }

  getbyName() async {
    var data =
        await firestore.collection(pharmaciesProductsCollectionName).get();
    setState(() {
      appGet.allResults.value = data.docs;
    });
    appGet.all();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              border: Border.all(color: grey2),
              color: mainColor),
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                            appGet.searchCatId = '';
                            appGet.searchPhrmId = '';
                            appGet.searchName = '';
                            appGet.category.clear();
                          },
                          child: appGet.lanid == 'Arabic'
                              ? SvgPicture.asset(
                                  'assets/images/ShapeFlip.svg',
                                  color: white,
                                  height: 16.h,
                                  width: 25.w,
                                )
                              : SvgPicture.asset(
                                  'assets/images/Shape.svg',
                                  color: white,
                                  height: 16.h,
                                  width: 25.w,
                                )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 3.0,
                        shadowColor: black,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              appGet.searchName = '';
                              appGet.searchName =
                                  _searchController.text.toString();
                            });
                          },
                          onSubmitted: (value) {
                            appGet.all();
                          },
                          cursorColor: mainColor,
                          decoration: InputDecoration(
                            hintText: 'searchmedicine'.tr,
                            isDense: true,
                            filled: true,
                            fillColor: white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(
                              Icons.tune_rounded,
                              color: HexColor('#196737'),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: TextStyle(
                                color: HexColor('#196737'),
                                fontSize: 14.sp,
                                fontFamily: montserratBold),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(134.h),
      ),
      body: Obx(
        () => ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w, right: 25.w),
              child: SizedBox(
                  height: 36.h,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showFilter();
                        },
                        child: Wrap(children: [
                          Container(
                            height: 36.h,
                            width: 110.w,
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexColor('#CECECE').withOpacity(.5),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,
                                      color: HexColor('#666769'), size: 12),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    'filter'.tr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: montserratBold,
                                        color: HexColor('#666769')),
                                  ),
                                ]),
                          ),
                        ]),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: appGet.category.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 36.h,
                                width: 110.w,
                                margin:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: HexColor('#CECECE').withOpacity(.5),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        appGet.category[index],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: montserratBold,
                                            color: HexColor('#666769')),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            appGet.category.removeAt(index);
                                            appGet.searchCatId = '';
                                            appGet.searchPhrmId = '';
                                            appGet.all();
                                          });
                                        },
                                        child: Container(
                                          height: 16.h,
                                          width: 16.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: HexColor('#047725'),
                                          ),
                                          child: Icon(Icons.close,
                                              color: white, size: 12),
                                        ),
                                      ),
                                    ]),
                              );
                            }),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: GridView.builder(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 50.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 22),
                itemCount: appGet.resultsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => MedicationsDetails(
                              appGet.resultsList[index]['medicineId']
                                  .toString(),
                              appGet.resultsList[index]['medicineName']
                                  .toString(),
                              appGet.resultsList[index]['medicineImage']
                                  .toString(),
                              appGet.resultsList[index]['medicinePrice']
                                  .toString(),
                              appGet.resultsList[index]['medicineDescription']
                                  .toString(),
                              appGet.resultsList[index]['categoryId']
                                  .toString(),
                              appGet.resultsList[index]['medicineAvailability']
                                  .toString(),
                              appGet.resultsList[index]['medicineHowToUse']
                                  .toString(),
                              appGet.resultsList[index]['pharmaceyId']
                                  .toString(),
                              appGet.resultsList[index]['categoryName']
                                  .toString(),
                              appGet.resultsList[index]['pharmName'].toString(),
                            ));
                      },
                      child: MedicationsCard(
                        appGet.resultsList[index]['medicineId'].toString(),
                        appGet.resultsList[index]['medicineName'].toString(),
                        appGet.resultsList[index]['medicineImage'].toString(),
                        appGet.resultsList[index]['medicinePrice'].toString(),
                        appGet.resultsList[index]['medicineDescription']
                            .toString(),
                        appGet.resultsList[index]['categoryId'].toString(),
                        appGet.resultsList[index]['medicineAvailability']
                            .toString(),
                        appGet.resultsList[index]['medicineHowToUse']
                            .toString(),
                        appGet.resultsList[index]['pharmaceyId'].toString(),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future showFilter() {
    return showModalBottomSheet(
        elevation: 0,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(children: <Widget>[
              Container(
                  alignment: Alignment.bottomCenter,
                  height: 400.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        topRight: Radius.circular(20.w),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, -3),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 36.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Align(
                          alignment: appGet.lanid == 'English'
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Text(
                            'pharmacies'.tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: montserratBold,
                                color: mainGreen),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                          height: 60.h,
                          child: StreamBuilder(
                              stream: getAllPharmacies(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return snapshot.hasData
                                    ? ListView.builder(
                                        padding: EdgeInsets.only(
                                            right: 10.w, left: 10.w),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.size,
                                        itemBuilder: (context, index) {
                                          return FilterCard(
                                            snapshot
                                                .data!.docs[index]['pharmName']
                                                .toString(),
                                            snapshot.data!.docs[index]['userId']
                                                .toString(),
                                          );
                                        },
                                      )
                                    : Text('');
                              })),
                      SizedBox(height: 45.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Align(
                          alignment: appGet.lanid == 'English'
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Text(
                            'categories'.tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: montserratBold,
                                color: mainGreen),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                          height: 60.h,
                          child: StreamBuilder(
                              stream: getAllCategories(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return snapshot.hasData
                                    ? ListView.builder(
                                        padding: EdgeInsets.only(
                                            right: 10.w, left: 10.w),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.size,
                                        itemBuilder: (context, index) {
                                          return CategoriesCard(
                                            snapshot
                                                .data!.docs[index]['catName']
                                                .toString(),
                                            snapshot.data!.docs[index]['catId']
                                                .toString(),
                                          );
                                        },
                                      )
                                    : Text('');
                              })),
                    ],
                  )),
            ]);
          });
        });
  }
}
