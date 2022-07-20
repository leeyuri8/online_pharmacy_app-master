import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../backend/firebase.dart';
import '../helpers/utile.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  rout() async {
    await Future.delayed(const Duration(seconds: 3));
    gettoken();
  }

  @override
  void initState() {
    super.initState();
    rout();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    WidgetRelease().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/medicines.svg'),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'drugdelivery'.tr,
              style: TextStyle(
                  color: mainColor,
                  fontFamily: montserratBold,
                  fontSize: 41.sp,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
