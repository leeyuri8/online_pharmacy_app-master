import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/Chat/CahtList.dart';
import 'package:drug_delivery_application/screens/pharmacey/CahtList.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/TabBarPharm/InventoryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../AllOrder/AllOrders.dart';
import '../PharmProfile copy/PharmProfile.dart';

class PharmNavBar extends StatefulWidget {
  
  const PharmNavBar({Key? key}) : super(key: key);

  @override
  State<PharmNavBar> createState() => _PharmNavBarState();
}

class _PharmNavBarState extends State<PharmNavBar> {
  List<Widget> listScreens = [];
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    listScreens = [DrugDelieveryscr(), Inventory(), PharmChatList(), PharmProfile()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens[_pageIndex],
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 10,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/pharmacy-medicine.svg',
                height: 22.h,
              ),
              label: 'orders'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/medical-report.svg'),
              label:'inventory'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/textmessage.svg'),
              label: 'chat'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/person.svg'),
              label: 'myacc'.tr,
            ),
          ],
          selectedItemColor: mainColor,
          unselectedItemColor: HexColor('#838181'),
          selectedLabelStyle: TextStyle(
              fontSize: 10.sp,
              fontFamily: poppins,
              fontWeight: FontWeight.w800),
          unselectedLabelStyle: TextStyle(
              fontSize: 10.sp,
              fontFamily: poppins,
              fontWeight: FontWeight.w800),
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
