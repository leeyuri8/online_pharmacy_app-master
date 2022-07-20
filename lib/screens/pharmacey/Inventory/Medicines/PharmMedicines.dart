import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Medicines/AddNewMedicine.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Medicines/PharmMedicineDetails.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Medicines/PharmMedicinesCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PharmMedicines extends StatefulWidget {
  PharmMedicines({Key? key,}) : super(key: key);

  @override
  State<PharmMedicines> createState() => _PharmMedicinesState();
}

class _PharmMedicinesState extends State<PharmMedicines> {
   User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
    
    
     body: ListView(
      padding: EdgeInsets.all(8),
   

      children: <Widget> [
        
        Padding(
          padding: EdgeInsets.all(10),
             child: Row(  
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                     'alldrugs'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: mainColor,
                          fontFamily: montserratBold,
                          fontWeight: FontWeight.w800),
                    ),
                  ]
                  ),
                  
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => AddNewMedicine());
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label:  Text(
                      'addnew'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(mainColor),
                     
                    ),
                   // style: ButtonStyle(foregroundColor: )
                    // textColor: Color.fromRGBO(255, 255, 255, 1),
                    // splashColor: green,
                    // color: mainColor,
                  ),
                ]
                )),
     Padding(
              padding: EdgeInsets.only(top: 17.h),
              child:
            StreamBuilder(
            stream: getAllProducts(user!.uid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
             return snapshot.hasData
                        ?   
           
            ListView.builder (
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: (){
                },
                  onTap: () {
                    Get.to(() => 
                    PharmMedicationsDetails(
                snapshot.data!
                      .docs[index]['medicineId']
                    .toString(),
                snapshot.data!
                    .docs[index]['medicineName']
                    .toString(),
                snapshot.data!
                    .docs[index]['medicineImage']
                    .toString(),
                snapshot.data!
                    .docs[index]['medicinePrice']
                    .toString(),
                snapshot
                    .data!
                    .docs[index]
                        ['medicineDescription']
                    .toString(),
                snapshot.data!
                    .docs[index]['categoryId']
                    .toString(),
                snapshot
                    .data!
                    .docs[index]
                        ['medicineAvailability']
                    .toString(),
                snapshot
                    .data!
                    .docs[index]
                        ['medicineHowToUse']
                    .toString(),
                snapshot.data!
                    .docs[index]['pharmaceyId']
                    .toString(),
                    //  snapshot.data!
                    // .docs[index]['categoryName']
                    // .toString(),
                    //   snapshot.data!
                    // .docs[index]['pharmName']
                    // .toString(),
             ));
                  },
        child: Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                      right:4.w,
                    ),
              child: PharmMedicinesCard(

                  snapshot.data!
                .docs[index]['medicineId']
                .toString(),
            snapshot.data!
                .docs[index]['medicineName']
                .toString(),
            snapshot.data!
                .docs[index]['medicineImage']
                .toString(),
            snapshot.data!
                .docs[index]['medicinePrice']
                .toString(),
            snapshot
                .data!
                .docs[index]
                    ['medicineDescription']
                .toString(),
            snapshot.data!
                .docs[index]['categoryId']
                .toString(),
                 snapshot.data!
                .docs[index]['categoryName']
                .toString(),
                
            snapshot
                .data!
                .docs[index]
                    ['medicineAvailability']
                .toString(),
            snapshot
                .data!
                .docs[index]
                    ['medicineHowToUse']
                .toString(),
            snapshot.data!
                .docs[index]['pharmaceyId']
                .toString(),
          ) ,
              
           ));
           
            },
            ): Text('');
                                
            }
                        
            )                      

              )
      ])));    
          
  
  }
    
            
        
  }