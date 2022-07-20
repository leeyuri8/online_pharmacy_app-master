import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../helpers/theme.dart';
import '../../../../helpers/utile.dart';

class DetailsCard extends StatefulWidget {
  final String name;
  final String image;
  final String address;
  final String phone;
  DetailsCard(this.name, this.image, this.address, this.phone, {Key? key})
      : super(key: key);

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172.h,
      width: 345.w,
      margin: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: HexColor('#F9F9F9')),
      child: Stack(
        children: [
          Align(
            alignment: appGet.lanid == 'English'
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: Container(
              width: 90.w,
              height: 33.h,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/contactBack.png'),
                      fit: BoxFit.fill)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          WidgetRelease.getInstance().sendSms(widget.phone);
                        },
                        child: SvgPicture.asset(
                            'assets/images/sms-messages.svg',
                            width: 18.w)),
                    GestureDetector(
                        onTap: () {
                          WidgetRelease.getInstance()
                              .makePhoneCall(widget.phone);
                        },
                        child: SvgPicture.asset('assets/images/phone-call.svg',
                            width: 18.w)),
                    GestureDetector(
                        onTap: () {
                          WidgetRelease.getInstance()
                              .whatsAppOpen(widget.phone);
                        },
                        child: SvgPicture.asset(
                            'assets/images/whatsapp-color.svg',
                            width: 18.w)),
                  ]),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: WidgetRelease.getInstance().cashed(
                  widget.image,
                  153,
                  153,
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: HexColor('#196737'))),
                  SizedBox(height: 13.h),
                  Text(widget.address,
                      style: TextStyle(fontSize: 13.sp, color: grey2)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
