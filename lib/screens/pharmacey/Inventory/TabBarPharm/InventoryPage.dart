import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/pharmacey/FilterScreen.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Category/Categories.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Medicines/PharmMedicines.dart';
import 'package:drug_delivery_application/screens/user/FilterScreen/FilterScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Inventory extends StatefulWidget {
  
  Inventory({Key? key,}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 145.h,
              actions: [],
              title: Column(
                children: [
                   Text(
                    "inventory".tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                    GestureDetector(
            onTap: () {
              Get.to(() => PharmFilterScreen());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3.0,
                    shadowColor: black,
                    child: TextField(
                      enabled: false,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        hintText: 'searchmedicine'.tr,
                        filled: true,
                        fillColor: white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Icon(
                          Icons.tune_rounded,
                          color: HexColor('#196737'),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
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
          ),
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 118, 158, 73),

              elevation: 2,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(0))),

              //   bottom: AppBar(

              //    backgroundColor: const Color.fromARGB(255, 118, 158, 73) ,
              //    elevation: 2,
              //   shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.vertical(
              //       bottom: const Radius.circular(20)
              //  )
              //  ),
              //    title: Container(
              //    width: double.infinity,
              //      height: 45,
              //      color: Colors.white,
              //      child: const Center(
              //        child: TextField(
              //          decoration: InputDecoration(
              //            hintText: "Search medicine available.",
              //            hintStyle: TextStyle(color: Color.fromARGB(255, 118, 158, 73),
              //            fontFamily: "Avenir-Medium",
              //            fontSize: 15,
              //            ),
              //              prefixIcon: Icon(Icons.search,color: Color.fromARGB(255, 118, 158, 73),),
              //             // suffixIcon: Icon(Icons.edit),
              //          ),
              //        ),
              //      ),
              //    ),
              // flexibleSpace:
              //      const TextField(
              //          decoration: InputDecoration(
              //            hintText: "Search medicine available.",
              //            hintStyle: TextStyle(color: Color.fromARGB(255, 118, 158, 73),
              //            fontFamily: "Avenir-Medium",
              //            fontSize: 15,
              //            ),),),
              bottom: TabBar(
                indicatorColor: white,
                tabs: [
                  Tab(
                    text: "medicines".tr,
                  ),
                  Tab(
                    text: "categories".tr,
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [PharmMedicines(), PharmCategories()],
            ),
          ),
        ));
  }
}
