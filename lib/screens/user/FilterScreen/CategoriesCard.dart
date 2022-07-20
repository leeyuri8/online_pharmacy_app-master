import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../backend/firebase.dart';
import '../../../helpers/theme.dart';

class CategoriesCard extends StatefulWidget {
  final String name;
  final String id;
  CategoriesCard(this.name, this.id, {Key? key}) : super(key: key);

  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          var isthere =
              appGet.category.where((element) => element == widget.name);
          if (isthere.isEmpty) {
            appGet.addCategory(widget.name);
            appGet.searchCatId = widget.id;

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
          color: isSelected ? mainColor : HexColor('#E6E6E6'),
        ),
        child: Center(
          child: Text(widget.name,
              style: TextStyle(
                  color: isSelected ? white : HexColor('#666769'),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: montserratBold)),
        ),
      ),
    );
  }
}
