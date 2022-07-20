import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Medicines/PharmMedicines.dart';
import 'package:drug_delivery_application/screens/user/Medications/Medications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../helpers/utile.dart';

class PharmCategoriesCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  PharmCategoriesCard(this.id, this.name, this.image, {Key? key}) : super(key: key);

  @override
  State<PharmCategoriesCard> createState() => _PharmCategoriesCard();
}

class _PharmCategoriesCard extends State<PharmCategoriesCard> {
//  User? user = FirebaseAuth.instance.currentUser;
// //CollectionReference coll = FirebaseFirestore.instance.collection("categories");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      height: 160.h,
      width: 150.w,
      decoration:
       BoxDecoration(borderRadius: BorderRadius.circular(5), color: white),
     
     
     child: Column(
     crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          WidgetRelease.getInstance().cashed(
            widget.image,
            70,
            100,
          ),
          SizedBox(height: 27.h),
    
         
          Container(
            
            height: 40.h,
            width: double.infinity,
          
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/medback.png'),
                    fit: BoxFit.fill)),
            child: Center(
              child: Text(
                widget.name,
                style: TextStyle(
                    color: white, fontSize: 15.sp, fontFamily: montserratBold, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ]  )
      )
    );
    
    }
    
     
   
   
  }
  

