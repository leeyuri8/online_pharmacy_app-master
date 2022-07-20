import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user/AddAddress/AddAddress.dart';

class VerfiyEmail extends StatefulWidget {
  final String name;
  final String email;
  final int isUser;
  VerfiyEmail(this.name, this.email, this.isUser, {Key? key}) : super(key: key);

  @override
  State<VerfiyEmail> createState() => _VerfiyEmailState();
}

class _VerfiyEmailState extends State<VerfiyEmail> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerfied();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
          '${'emailsent'.tr} ${widget.email} ${'pleaseverfiy'.tr}',
        textAlign: TextAlign.center,
      ),
    ));
  }

  Future<void> checkEmailVerfied() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Get.offAll(() => AddAddress(widget.name, widget.isUser));
    }
  }
}
