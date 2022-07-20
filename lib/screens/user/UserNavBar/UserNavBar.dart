import 'package:badges/badges.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/Chat/CahtList.dart';
import 'package:drug_delivery_application/screens/user/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../backend/firebase.dart';
import '../Cart/Cart.dart';
import '../UserProfile/UserProfile.dart';

class UserNavBar extends StatefulWidget {
  const UserNavBar({Key? key}) : super(key: key);

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {
  List<Widget> listScreens = [];
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    listScreens = [HomePage(), Cart(), ChatList(), UserProfile()];
    getUserCart();
    getnotification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  'assets/images/home.svg',
                  height: 22.h,
                ),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Obx(
                  () => Badge(
                      showBadge: appGet.cartList.isNotEmpty ? true : false,
                      badgeColor: HexColor('#D4721B'),
                      elevation: 0,
                      position: BadgePosition.topEnd(top: -8, end: -3),
                      badgeContent: Text(
                        appGet.cartList.length.toString(),
                        style: TextStyle(
                            color: white, fontWeight: FontWeight.bold),
                      ),
                      child:
                          SvgPicture.asset('assets/images/shoppingcart.svg')),
                ),
                label: 'shoppingcart'.tr,
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
      ),
    );
  }
}
