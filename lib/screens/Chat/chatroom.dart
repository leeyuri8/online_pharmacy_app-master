// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_literals_to_create_immutables

import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:drug_delivery_application/screens/Chat/recordvoice.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../backend/firebase.dart';
import '../../helpers/utile.dart';
import '../user/Medications/appBar/AppBars.dart';
import 'palyaudio.dart';
import 'showimage.dart';

class ChatRoom extends StatefulWidget {
  final String usrreciverid;
  final String mosName;
  final String imageUrl;


  ChatRoom(this.usrreciverid, this.mosName, this.imageUrl, {Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
  LocalFileSystem? localFileSystem;
  FocusNode? myFocusNode;
  Animation<double>? _animation;
  AnimationController? _animationController;
  var msar = '';
  var taggg = Uuid().v4();
  var taggg2 = Uuid().v1();
  @override
  void initState() {
    FlutterAudioRecorder2.hasPermissions;
    myFocusNode = FocusNode();
    // myFocusNode!.addListener(_onFocusChange);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  int isoundvar = 0;

  String filePath = '';
  bool isUploading = false;

  bool micrec = false;
  bool showbuttons = false;
  double containerhight = 0;
  double opa = 0;
  @override
  void dispose() {
    myFocusNode!.dispose();

    super.dispose();
  }

  List<IconData> icons = [
    Icons.image,
    Icons.location_on,
    Icons.mic,
  ];
  bool showBottom = false;
  bool lscrl = false;
  getscroll() {
    if (lscrl == false) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 150,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 10),
      );
      lscrl = true;
    }
  }

  ScrollController scrollController = ScrollController();

  String tempPathForAudioMessages = '';
  bool ismapcaht = false;

  getupoff() {
    Timer(const Duration(milliseconds: 500), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  getSenderView(
          CustomClipper clipper,
          Widget ww,
          BuildContext context,
          bool isma,
          lat,
          lon,
          var isosund,
          String soundurl,
          bool isimage,
          String imagurl) =>

      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: HexColor('#b1cf97'),
        child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: isimage == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        msar = Uuid().v1();
                      });
                      Get.to(PhotoShow(msar, imagurl));
                    },
                    child: Hero(
                      tag: 'tt$msar',
                      child: WidgetRelease.getInstance().cashed(
                        imagurl,
                        90,
                        90,
                      ),
                    ))
                : isosund == true
                    ? Playsound(soundurl)
                    : isma == true
                        ? GestureDetector(
                            onTap: () {
                              print('sshow');
                            },
                          )
                        : ww),
      );

  getReceiverView(CustomClipper clipper, Widget ww, BuildContext context,
          bool isma, lat, lon, var isosund, String soundurl) =>
      ChatBubble(
        clipper: clipper,
        backGroundColor:  HexColor('#C5DBB2'),
        margin: const EdgeInsets.only(top: 20),
        child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: isosund == true
                ? Playsound(soundurl)
                : isma == true
                    ? InkWell(
                        onTap: () {
                          print('sshow');
                        },
                      )
                    : ww),
      );
  gotoend() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  TextEditingController groupNameController = TextEditingController();
  TextEditingController controller = TextEditingController();
  Directory? appDirectory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBars('chatroom'.tr, false, 93, true, 90),
        body: Center(
          child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: StreamBuilder(
                        stream: getmychat(
                          widget.usrreciverid,
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  controller: scrollController,
                                  itemCount: snapshot.data!.size,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                        mainAxisAlignment: snapshot
                                                    .data!.docs[index]['sendby']
                                                    .toString() ==
                                                userIds 
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: snapshot.data!
                                                        .docs[index]['sendby']
                                                        .toString() ==
                                                    userIds 
                                                ? false
                                                : true,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 15,
                                                  right: 15),
                                              child: Text(
                                                snapshot.data!
                                                    .docs[index]['morslname']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          snapshot.data!.docs[index]['sendby']
                                                      .toString() ==
                                                  userIds 
                                              ? getSenderView(
                                                  ChatBubbleClipper4(
                                                      type: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                      ['sendby']
                                                                  .toString() ==
                                                             userIds
                                                          ? BubbleType
                                                              .sendBubble
                                                          : BubbleType
                                                              .receiverBubble),
                                                  Linkify(
                                                    onOpen: (link) async {
                                                    },
                                                    text: snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['detailes']
                                                            .toString() +
                                                        '\n' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time'] * 1000)
                                                            .year
                                                            .toString() +
                                                        '/' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time'] * 1000)
                                                            .month
                                                            .toString() +
                                                        '/' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time'] * 1000)
                                                            .day
                                                            .toString() +
                                                        '-' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['time'] *
                                                                1000)
                                                            .hour
                                                            .toString() +
                                                        ':' +
                                                        DateTime.fromMicrosecondsSinceEpoch(
                                                                snapshot.data!.docs[index]['time'] * 1000)
                                                            .minute
                                                            .toString(),
                                                    linkStyle: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  context,
                                                  snapshot.data!.docs[index]
                                                          ['islocation'] ??
                                                      false,
                                                  snapshot.data!.docs[index]
                                                          ['lat'] ??
                                                      0,
                                                  snapshot.data!.docs[index]
                                                          ['lon'] ??
                                                      0,
                                                  snapshot.data!.docs[index]
                                                          ['issound'] ??
                                                      false,
                                                  snapshot.data!.docs[index]
                                                          ['soundownload'] ??
                                                      '',
                                                  snapshot.data!.docs[index]
                                                          ['isimage'] ??
                                                      '',
                                                  snapshot.data!.docs[index]
                                                          ['imageurl'] ??
                                                      '',
                                                )
                                              : getReceiverView(
                                                  ChatBubbleClipper4(
                                                      type: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                      ['sendby']
                                                                  .toString() ==
                                                              userIds
                                                          ? BubbleType
                                                              .sendBubble
                                                          : BubbleType
                                                              .receiverBubble),
                                                  Linkify(
                                                    onOpen: (link) async {
                                                    },
                                                    text: snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['detailes']
                                                            .toString() +
                                                        '\n' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time'] * 1000)
                                                            .year
                                                            .toString() +
                                                        '/' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time'] * 1000)
                                                            .month
                                                            .toString() +
                                                        '/' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time'] * 1000)
                                                            .day
                                                            .toString() +
                                                        '-' +
                                                        DateTime.fromMicrosecondsSinceEpoch(snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['time'] *
                                                                1000)
                                                            .hour
                                                            .toString() +
                                                        ':' +
                                                        DateTime.fromMicrosecondsSinceEpoch(
                                                                snapshot.data!.docs[index]['time'] * 1000)
                                                            .minute
                                                            .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    linkStyle: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  context,
                                                  snapshot.data!.docs[index]
                                                          ['islocation'] ??
                                                      false,
                                                  snapshot.data!.docs[index]
                                                          ['lat'] ??
                                                      0,
                                                  snapshot.data!.docs[index]
                                                          ['lon'] ??
                                                      0,
                                                  snapshot.data!.docs[index]
                                                          ['issound'] ??
                                                      false,
                                                  snapshot.data!.docs[index]
                                                          ['soundownload'] ??
                                                      '',
                                                ),
                                          Visibility(
                                            visible: snapshot.data!
                                                        .docs[index]['sendby']
                                                        .toString() ==
                                                    userIds
                                                ? true
                                                : false,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 15,
                                                  right: 15),
                                              child: SizedBox(
                                                width: 50,
                                                child: Text(
                                                  snapshot.data!
                                                      .docs[index]['morslname']
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]);
                                  })
                              : const Text('No');
                        }),
                  ),
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, bottom: 20.h),
                        child: TextField(
                          autofocus: true,
                          focusNode: myFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          controller: groupNameController,
                          
                          decoration: InputDecoration(
                            hintText: 'typeyourmess'.tr,
                            filled: true,
                            fillColor: HexColor('#C5DBB2'),
                            prefixIcon: SizedBox(
                              width: 100.w,
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    margin:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.photo_camera_outlined,
                                          color: white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            showbuttons = !showbuttons;
                                            opa = showbuttons ? 1 : 0;
                                            containerhight =
                                                containerhight == 1500
                                                    ? 100
                                                    : 150;
                                          });
                                        }),
                                  ),
                                  Recordvoice(
                                      widget.mosName,
                                      widget.usrreciverid,
                                      groupNameController.text,
                                      '', widget.imageUrl),
                                ],
                              ),
                            ),
                            suffixIcon: SizedBox(
                              width: 40,
                              child: IconButton(
                                  icon: Icon(Icons.send, color: mainColor),
                                  onPressed: () {
                                    savechatFirestore(
                                        
                                        widget.mosName,
                                        widget.usrreciverid,
                                        groupNameController.text,
                                        ismapcaht,
                                        0.0,
                                        0.0,
                                        '',
                                        false,
                                        false,
                                        '',
                                       widget. imageUrl,
                                        );

                                    ismapcaht = false;
                                    groupNameController.text = '';

                                    Timer(const Duration(milliseconds: 500),
                                        () {
                                      scrollController.jumpTo(scrollController
                                          .position.maxScrollExtent);
                                    });
                                  }),
                            ),
                            

                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                    color: HexColor('#C5DBB2'), width: 2.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor('#C5DBB2'), width: 2.0),
                                borderRadius: BorderRadius.circular(25.0)),
                            labelText: '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: AnimatedContainer(
                height: 100.h,
                width: 250,
                decoration: BoxDecoration(
                  color: HexColor("#C5DBB2"),
                  borderRadius: BorderRadius.circular(20),
                ),
                duration: const Duration(seconds: 1),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          heroTag: taggg,
                          onPressed: () {
                            appGet.getImages(ImageSource.camera).then((value) {
                              uploadchatImage(appGet.selectedImagePath.value)
                                  .then((value) {
                                savechatFirestore(
                                        widget.mosName,
                                        widget.usrreciverid,
                                        groupNameController.text,
                                        false,
                                        0,
                                        0,
                                        value!,
                                        false,
                                        true,
                                        value,widget.imageUrl )
                                    .then((value) {
                                  Timer(const Duration(milliseconds: 500), () {
                                    scrollController.jumpTo(scrollController
                                        .position.maxScrollExtent);
                                  });
                                });
                              });
                            });
                          },
                          backgroundColor: Colors.red,
                          child: const Icon(Icons.camera_alt),
                        ),
                        FloatingActionButton(
                          heroTag: taggg2,
                          onPressed: () {
                              
                            appGet.getImages(ImageSource.gallery).then((value) {
                              uploadchatImage(appGet.selectedImagePath.value)
                                  .then((value) {
                                savechatFirestore(
                                        widget.mosName,
                                        widget.usrreciverid,
                                        groupNameController.text,
                                        false,
                                        0,
                                        0,
                                        value!,
                                        false,
                                        true,
                                        value, widget.imageUrl)
                                    .then((value) {
                                  Timer(const Duration(milliseconds: 500), () {
                                    scrollController.jumpTo(scrollController
                                        .position.maxScrollExtent);
                                  });
                                });
                              });
                            });
                          },
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.image),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                )),
          ),
          opacity: opa,
        ),
      ),
    );
  }
}
