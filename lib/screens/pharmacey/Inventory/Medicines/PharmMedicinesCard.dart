import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/helpers/utile.dart';
import 'package:drug_delivery_application/screens/pharmacey/Inventory/Medicines/PharmMedicineDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class PharmMedicinesCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;
    final String categoryId;

  final String categoryName;

  final String avalibilty;
  final String howToUse;
  final String pharmId;
  

  PharmMedicinesCard(this.id, this.name, this.image, this.price, this.description,this.categoryId,
      this.categoryName, this.avalibilty, this.howToUse, this.pharmId,
      {Key? key})
      : super(key: key);

  @override
  State<PharmMedicinesCard> createState() => _PharmMedicinesCardState();
}

class _PharmMedicinesCardState extends State<PharmMedicinesCard> {
   bool _switchValue = true;
  
  @override
  void initState() {
    super.initState();
    print(widget.avalibilty);
    if(widget.avalibilty == '1'){
       _switchValue = false;
    }
     _switchValue = true;
    
  }
  @override
  Widget build(BuildContext context) {

   return Container(
     height: 145.h,
     
    
    child: Card(
      elevation: 2,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Padding(padding: EdgeInsets.all(.10),
         child: GestureDetector(
          
        child:  ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: WidgetRelease.getInstance().cashed(
              widget.image,
              120,
              100,
            ),
          ),

         ),
         
         ),
         Padding(
           padding:EdgeInsets.all(10) ,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
           Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
           Text(widget.categoryName.tr, style: TextStyle(color: grey),),
           Text(  widget.avalibilty == '1' ? 'instock'.tr : 'outstock'.tr, style: TextStyle(color: grey),)           
           ],
          )
         ),
         Padding(padding: EdgeInsets.all(8),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             FlutterSwitch(
                      height: 20.0,
                      width: 40.0,                    
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: mainColor,
                      value: _switchValue,
                      onToggle: (value) {
                        setState(() {  
                           _switchValue = value;
                           print(value);
                           print(widget.avalibilty);
                           
                           widget.avalibilty == '1' ? updateProductAvailability('0', widget.id): updateProductAvailability('1', widget.id);
                          // updateProductAvailability('0', widget.id);
        

                        });
                      },
                    ),
                    
                       ElevatedButton.icon(
                              onPressed: () {
                               _showDialog(context);
                              },
                              icon: Icon(Icons.delete, color: mainColor,),
                              label: Text('delete'.tr,  style: TextStyle(color: mainColor)),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 12),
                                backgroundColor: white
          ),
        ),
                   
           ],
         ),
         )
        ],
      ),

    ),
    );
  }
   _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Delete Alert'),
            content: Text('deleteconfirm'.tr),
            actions: [
              TextButton(
                onPressed: () {
                  deleteProduct(widget.id);
                  Navigator.of(context).pop();
                },
                child: Text('ok'.tr, style: TextStyle(color: Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel'.tr, style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        );
      },
    );  
  }
  _updateOrderStatus(BuildContext context){


  }
  

}
