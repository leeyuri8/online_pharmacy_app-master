import 'package:drug_delivery_application/screens/chooseAccount/chooseAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../helpers/theme.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  final PageController _pageController = PageController();
  final List<OnBoardModel> onBoardData = [
    OnBoardModel(
      title: "nolong".tr,
      description: "explore".tr,
      imgUrl: "assets/images/onboard1.svg",
    ),
    OnBoardModel(
      title: "deliveryon".tr,
      description: "getyour".tr,
      imgUrl: 'assets/images/onboard2.svg',
    ),
    OnBoardModel(
      title: "deliveryarrived".tr,
      description: 'orderarrived'.tr,
      imgUrl: 'assets/images/onboard3.svg',
    ),
  ];

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      Get.to(() => ChooseAccount());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        onBoardData: onBoardData,
        titleStyles: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            fontFamily: poppins,
            color: onBoardingTitle),
        descriptionStyles: TextStyle(
            fontSize: 15.sp, color: onBoardingbody, fontFamily: poppins),
        pageIndicatorStyle: PageIndicatorStyle(
          width: 70,
          inactiveColor: grey,
          activeColor: mainColor,
          inactiveSize: Size(10.w, 10.h),
          activeSize: Size(10.w, 10.h),
        ),
        skipButton: TextButton(
          onPressed: () {
            Get.to(() => ChooseAccount());
          },
          child: Text(
            "skip".tr,
            style: TextStyle(color: grey),
          ),
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 146.w,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: buttonMain),
                child: Text(
                  state.isLastPage ? "done".tr : "next".tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
