import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatCard extends StatefulWidget {
  final int creatdate;
  final String detailes;
  final String morslname;
  final String mosname;
  final String userId;
  final String state;
  final String image;
  ChatCard(this.creatdate, this.detailes, this.morslname, this.mosname,
      this.userId, this.state, this.image,
      {Key? key})
      : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    var recDate =
        DateTime.fromMillisecondsSinceEpoch(widget.creatdate, isUtc: true);
    return Column(
      children: [
        Container(
          height: 100.h,
          margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 56.w,
              height: 54.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        widget.mosname,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: montserratBold,
                            color: black),
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                    ),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        recDate.toString().substring(0, 10),
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: montserratBold,
                            color: HexColor('#8C8C8C')),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 35.h,
                  width: 250.w,
                  child: Text(
                    widget.detailes,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: montserratBold,
                        color: HexColor('#8C8C8C')),
                  ),
                ),
              ],
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          height: 1.h,
          color: HexColor('#0D0925').withOpacity(.1),
        )
      ],
    );
  }
}
