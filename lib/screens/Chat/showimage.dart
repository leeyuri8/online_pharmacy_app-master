import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../user/Medications/appBar/AppBars.dart';

class PhotoShow extends StatefulWidget {
  final String uui;
  final String photo;
  PhotoShow(this.uui, this.photo, {Key? key}) : super(key: key);

  @override
  _PhotoShowState createState() => _PhotoShowState();
}

class _PhotoShowState extends State<PhotoShow> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBars('photo'.tr, false, 93, true, 115),
        body: Container(
          color: Colors.white,
          child: Center(
              child: Hero(
            child: Container(
              height: 400,
              width: 400,
              child: Image.network(
                widget.photo,
                fit: BoxFit.fill,
              ),
            ),
            tag: widget.uui,
          )),
        ),
      ),
    );
  }
}
