import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';


class FilterCard extends StatefulWidget {
  final String name;
  final String id;
  FilterCard(this.name, this.id, {Key? key}) : super(key: key);

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  bool isselect = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isselect = !isselect;
          var isthere =
              appGet.category.where((element) => element == widget.name);
          if (isthere.isEmpty) {
            appGet.addCategory(widget.name);
            appGet.searchPhrmId = widget.id;
           appGet.all();
          } else {}
        });
      },
      child: Container(
        height: 49.h,
        width: 124.w,
        margin: EdgeInsets.only(left: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isselect ? mainColor : HexColor('#E6E6E6'),
        ),
        child: Center(
          child: Text(widget.name,
              style: TextStyle(
                  color: isselect ? white : HexColor('#666769'),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: montserratBold)),
        ),
      ),
    );
  }
}
