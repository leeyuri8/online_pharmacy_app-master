import 'package:drug_delivery_application/screens/user/AllPharmacey/PharmaceyDetails/Cards/mostPopular.dart';
import 'package:drug_delivery_application/screens/user/HomePage/cards/categoriesCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../backend/firebase.dart';
import '../../../../helpers/theme.dart';
import '../../../Chat/chatroom.dart';
import '../../Medications/Medications.dart';
import '../../Medications/MedicationsDetails/MedicationsDetails.dart';
import 'DetailsCard.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PharmaceyDetails extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String address;
  final String phone;
  final String openHours;
  final double rating;
  PharmaceyDetails(this.id, this.name, this.image, this.address, this.phone,
      this.openHours, this.rating,
      {Key? key})
      : super(key: key);

  @override
  State<PharmaceyDetails> createState() => _PharmaceyDetailsState();
}

class _PharmaceyDetailsState extends State<PharmaceyDetails> {
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;
  late double _rating;
  IconData? _selectedIcon;

  double avRating = 0.0;

  @override
  void initState() {
    super.initState();
    avRating = widget.rating;
    getMedicationsByPharm(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          child: Container(
            height: 93.h,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                border: Border.all(color: grey2),
                color: mainColor),
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
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
                  Text(
                    'pharmdetails'.tr,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: white,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w800),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(() =>
                            ChatRoom(widget.id, widget.name, widget.image));
                      },
                      child: Icon(
                        Icons.message_rounded,
                        color: white,
                      ))
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(93.h),
        ),
        body: Obx(
          () => ListView(padding: EdgeInsets.only(bottom: 50.h), children: [
            DetailsCard(
              widget.name,
              widget.image,
              widget.address,
              widget.phone,
            ),
            Padding(
              padding: EdgeInsets.only(top: 22.h, left: 29.w, right: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: mainGreen,
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: avRating,
                        minRating: 1,
                        allowHalfRating: true,
                        direction:
                            _isVertical ? Axis.vertical : Axis.horizontal,
                        unratedColor: Colors.amber.withAlpha(50),
                        itemCount: 5,
                        itemSize: 15.0,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          _selectedIcon ?? Icons.star,
                          color: HexColor('#FFB238'),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                            avRating = (avRating + rating) / 2;

                            ratePharm(avRating, widget.id);
                          });
                        },
                        updateOnDrag: true,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        avRating.toStringAsFixed(1).toString(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: HexColor('#FFB238'),
                            fontFamily: montserratBold,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 21.h, left: 29.w, right: 19.w),
              child: Text('Medicine, Beauty & supplies',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w500,
                      color: mainGreen)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 29.w, right: 19.w),
              child: Row(
                children: [
                  Text('${'address'.tr}:',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: montserratBold,
                          fontWeight: FontWeight.w500,
                          color: HexColor('#666769'))),
                  SizedBox(width: 2.w),
                  Text(widget.address,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: montserratBold,
                          color: HexColor('#666769'))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 29.w, right: 19.w),
              child: Row(
                children: [
                  Text('${'hours'.tr}:',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: montserratBold,
                          fontWeight: FontWeight.w500,
                          color: HexColor('#666769'))),
                  SizedBox(width: 2.w),
                  Text(widget.openHours,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: montserratBold,
                          fontWeight: FontWeight.w500,
                          color: mainGreen)),
                ],
              ),
            ),
            Visibility(
              visible: appGet.pharmPro.isNotEmpty ? true : false,
              child: Padding(
                padding: EdgeInsets.only(top: 63.h, left: 15.w, right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('mostpopular'.tr,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: montserratBold,
                            fontWeight: FontWeight.w500,
                            color: mainGreen)),
                    Text('${'showitem'.tr} ${appGet.pharmPro.length}',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: montserratBold,
                            fontWeight: FontWeight.w500,
                            color: lightGrey)),
                  ],
                ),
              ),
            ),
            appGet.pharmPro.isEmpty
                ? Text('')
                : Visibility(
                    visible: appGet.pharmPro.isNotEmpty ? true : false,
                    child: SizedBox(height: 20.h)),
            Visibility(
              visible: appGet.pharmPro.isNotEmpty ? true : false,
              child: SizedBox(
                height: 140.h,
                child: appGet.pharmPro.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: appGet.pharmPro.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => MedicationsDetails(
                                    appGet.pharmPro[index]['medicineId']
                                        .toString(),
                                    appGet.pharmPro[index]['medicineName']
                                        .toString(),
                                    appGet.pharmPro[index]['medicineImage']
                                        .toString(),
                                    appGet.pharmPro[index]['medicinePrice']
                                        .toString(),
                                    appGet.pharmPro[index]
                                            ['medicineDescription']
                                        .toString(),
                                    appGet.pharmPro[index]['categoryId']
                                        .toString(),
                                    appGet.pharmPro[index]
                                            ['medicineAvailability']
                                        .toString(),
                                    appGet.pharmPro[index]['medicineHowToUse']
                                        .toString(),
                                    appGet.pharmPro[index]['pharmaceyId']
                                        .toString(),
                                    appGet.pharmPro[index]['categoryName']
                                        .toString(),
                                    appGet.pharmPro[index]['pharmName']
                                        .toString(),
                                  ));
                            },
                            child: MostPopular(
                              appGet.pharmPro[index]['medicineId'].toString(),
                              appGet.pharmPro[index]['medicineName'].toString(),
                              appGet.pharmPro[index]['medicineImage']
                                  .toString(),
                              appGet.pharmPro[index]['medicinePrice']
                                  .toString(),
                              appGet.pharmPro[index]['medicineDescription']
                                  .toString(),
                              appGet.pharmPro[index]['categoryId'].toString(),
                              appGet.pharmPro[index]['medicineAvailability']
                                  .toString(),
                              appGet.pharmPro[index]['medicineHowToUse']
                                  .toString(),
                              appGet.pharmPro[index]['pharmaceyId'].toString(),
                            ),
                          );
                        },
                      )
                    : Text(''),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 15.w, right: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('categories'.tr,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: montserratBold,
                          fontWeight: FontWeight.w700,
                          color: HexColor('#393939'))),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
                height: 180.h,
                child: StreamBuilder(
                    stream: getAllCategories(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => Medications(
                                        snapshot.data!.docs[index]['catId']
                                            .toString(),
                                        true,
                                        widget.id));
                                  },
                                  child: CategoriesCard(
                                    snapshot.data!.docs[index]['catId']
                                        .toString(),
                                    snapshot.data!.docs[index]['catName']
                                        .toString(),
                                    snapshot.data!.docs[index]['catImage']
                                        .toString(),
                                  ),
                                );
                              },
                            )
                          : Text('There is no messages ');
                    })),
          ]),
        ),
      ),
    );
  }
}
