import 'package:drug_delivery_application/screens/user/UserNavBar/UserNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../backend/firebase.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/theme.dart';
import '../../Medications/appBar/AppBars.dart';
import 'TrackCard/TrackCard.dart';
import 'package:enhance_stepper/enhance_stepper.dart';

class TrackOrder extends StatefulWidget {
  TrackOrder({Key? key}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int groupValue = 0;

  List<EnhanceStep> switchm(String id) {
    List<EnhanceStep> icon = [];
    switch (id) {
      case '1':
        icon = [
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "ordered".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.circle_outlined,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "shipped".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.circle_outlined,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "outfordelivery".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.circle_outlined,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "recived".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          )
        ];

        break;
      case '2':
        icon = [
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "ordered".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "shipped".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.circle_outlined,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "outfordelivery".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.circle_outlined,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "recived".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          )
        ];

        break;
      case '3':
        icon = [
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "ordered".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "shipped".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "outfordelivery".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.circle_outlined,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "recived".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          )
        ];

        break;
      case '4':
        icon = [
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "ordered".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "shipped".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "outfordelivery".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          ),
          EnhanceStep(
            icon: Icon(
              Icons.check_circle_outline,
              color: mainColor,
              size: 27,
            ),
            isActive: false,
            title: Text(
              "recived".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: montserratBold,
                fontWeight: FontWeight.w500,
                color: black1,
              ),
            ),
            content: Text(""),
          )
        ];

        break;
      default:
        Container();
    }
    return icon;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBars('trackorder'.tr, false, 93, true, 85),
        body: appGet.orderList.isNotEmpty
            ? ListView(padding: EdgeInsets.only(bottom: 50.h), children: [
                TrackCard(),
                EnhanceStepper(
                    currentStep: appGet.orderList[0]['orderStatus'] == 1
                        ? 0
                        : appGet.orderList[0]['orderStatus'] == 2
                            ? 1
                            : appGet.orderList[0]['orderStatus'] == 3
                                ? 2
                                : appGet.orderList[0]['orderStatus'] == 4
                                    ? 3
                                    : 0,
                    type: StepperType.vertical,
                    horizontalTitlePosition: HorizontalTitlePosition.bottom,
                    horizontalLinePosition: HorizontalLinePosition.top,
                    physics: NeverScrollableScrollPhysics(),
                    steps:
                        switchm(appGet.orderList[0]['orderStatus'].toString()),
                    onStepCancel: () {},
                    onStepContinue: () {},
                    onStepTapped: (index) {},
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Container();
                    }),
                Visibility(
                  visible: appGet.orderList[0]['orderStatus'].toString() == '4'
                      ? false
                      : true,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 44.h, left: 13.w, right: 13.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            updateOrderStatus(4, appGet.orderId).then((value) {
                              getUserOrder(appGet.orderId);
                              successSanck('', 'your order is completed',
                                  SnackPosition.BOTTOM);
                              Get.offAll(() => UserNavBar());
                            });
                          },
                          child: Container(
                              height: 52.h,
                              width: 188.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: mainColor),
                              child: Center(
                                  child: Text(
                                'confirmorder'.tr,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 13.sp,
                                  fontFamily: montserratBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => UserNavBar());
                          },
                          child: Container(
                              height: 52.h,
                              width: 188.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: HexColor('#F2F2F2')),
                              child: Center(
                                  child: Text(
                                'done'.tr,
                                style: TextStyle(
                                  color: black1,
                                  fontSize: 18.sp,
                                  fontFamily: montserratBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ))),
                        ),
                      ],
                    ),
                  ),
                )
              ])
            : Text(''),
      ),
    );
  }
}
