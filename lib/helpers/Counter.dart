import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../backend/firebase.dart';

class Counter extends StatefulWidget {
  Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  void add() {
    setState(() {
      appGet.qty++;
    });
  }

  void minus() {
    setState(() {
      if (appGet.qty != 0) appGet.qty--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: minus,
          child: Container(
            width: 25.w,
            height: 25.h,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: HexColor('#393939'),
                width: 1,
              ),
            ),
            child: Center(
              child: Icon(Icons.remove, size: 15, color: HexColor('#393939')),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          '${appGet.qty}',
          style: TextStyle(
              color: HexColor('#393939'),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              fontFamily: poppins),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () => add(),
          child: Container(
            width: 25.w,
            height: 25.h,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: HexColor('#393939'),
                width: 1,
              ),
            ),
            child: Center(
              child: Icon(Icons.add, size: 15, color: HexColor('#393939')),
            ),
          ),
        ),
      ],
    );
  }
}
