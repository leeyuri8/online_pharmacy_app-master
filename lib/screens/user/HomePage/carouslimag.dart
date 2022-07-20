import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carouslimg extends StatefulWidget {
  final String productimg;
  const Carouslimg(this.productimg, {Key? key}) : super(key: key);

  @override
  _CarouslimgState createState() => _CarouslimgState();
}

class _CarouslimgState extends State<Carouslimg> {
  int _current = 0;
  List both = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(widget.productimg.toString()),
                  ],
                ),
              );
            },
            options: CarouselOptions(
                height: 220.h,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: both.map((url) {
            int index = both.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
