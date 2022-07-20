import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:overlay_support/overlay_support.dart';

import 'backend/firebase.dart';
import 'helpers/theme.dart';
import 'lang/local.dart';
import 'screens/splash.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging firebaseMessaging;
  int totalnotificationcounter = 0;
  PushNotification? notificationinfo;

  void registernotifications() async {
    //on app open
    await Firebase.initializeApp();
    firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Authorized');
    } else {
      print('UnAuthorized');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('aaaaaa' + message.notification.toString());
      PushNotification notification = PushNotification(
        title: message.notification!.title.toString(),
        body: message.notification!.body ?? '',
        datatitle: message.data['title'] ?? '',
        databody: message.data['body'] ?? '',
      );
      setState(() {
        totalnotificationcounter++;
        notificationinfo = notification;
        appGet.totalnotificationcounterget.value = totalnotificationcounter;

        // appGet.pushmsg.add(notification.title);
        // appGet.pushmsg.add(notification.body);
        // safesharedlist();

        // print('push' + appGet.pushmsg.toString());
      });
      if (notification != null) {
        showSimpleNotification(
          Text(
            notificationinfo!.title.toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: montserratBold,
                fontWeight: FontWeight.bold),
          ),
          background: Colors.white,
          leading: SizedBox(
            width: 54.w,
            height: 54.h,
            child: SvgPicture.asset('assets/images/medicines.svg'),
          ),
          subtitle: Text(
            notificationinfo!.body.toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: montserratBold,
                fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 4),
        );
      }
    });
  }

  Future<void> openTheRecorder() async {
    // if (!kIsWeb) {
    //   var status = await Permission.microphone.request();
    //   if (status != PermissionStatus.granted) {
    //     throw RecordingPermissionException('Microphone permission not granted');
    //   }
    // }
  }

  @override
  void initState() {
    appGet.lanid.value;
    super.initState();
    openTheRecorder();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title.toString(),
        body: message.notification!.body.toString(),
        datatitle: message.data['title'],
        databody: message.data['body'],
      );
      setState(() {
        totalnotificationcounter++;
        notificationinfo = notification;
      });
      if (notification != null) {
        showSimpleNotification(
          Text(
            notificationinfo!.title,
            style: TextStyle(
                color: Colors.black,
                fontFamily: montserratBold,
                fontWeight: FontWeight.bold),
          ),
          background: Colors.white,
          leading: SizedBox(
            width: 54.w,
            height: 54.h,
            child: SvgPicture.asset('assets/images/medicines.svg'),
          ),
          subtitle: Text(
            notificationinfo!.body,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: montserratBold),
          ),
          duration: Duration(seconds: 4),
        );
      }
    });
    registernotifications();
    checkinit();
    FirebaseMessaging.instance.subscribeToTopic('topic');
    FirebaseMessaging.instance.getToken().then((token) {
      print('A new token was generated: $token');
      appGet.fcmToken = token!;
    });
  }

  checkinit() async {
    //on app termniate
    RemoteMessage? initialmessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialmessage != null) {
      PushNotification notification = PushNotification(
        title: initialmessage.notification!.title.toString(),
        body: initialmessage.notification!.body.toString(),
        datatitle: initialmessage.data['title'],
        databody: initialmessage.data['body'],
      );
      setState(() {
        totalnotificationcounter++;
        notificationinfo = notification;
      });
      if (notification != null) {
        showSimpleNotification(
          Text(
            notificationinfo!.title,
            style: TextStyle(
                color: Colors.black,
                fontFamily: montserratBold,
                fontWeight: FontWeight.bold),
          ),
          background: Colors.white,
          leading: SizedBox(
            width: 54.w,
            height: 54.h,
            child: SvgPicture.asset('assets/images/medicines.svg'),
          ),
          subtitle: Text(
            notificationinfo!.body,
            style: TextStyle(color: Colors.black, fontFamily: montserratBold),
          ),
          duration: const Duration(seconds: 4),
        );
      }
    }
  }

  // @override
  // void initState() {
  //   firebaseMessaging = FirebaseMessaging.instance;
  //   registerNotification();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(357, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => OverlaySupport.global(
        child: GetMaterialApp(
          builder: EasyLoading.init(),
          title: 'Drug Delivery',
          theme: ThemeData(
              fontFamily: 'Montserrat',
              primaryColor: const Color.fromARGB(255, 105, 160, 58)),
          debugShowCheckedModeBanner: false,
          locale: LocalizationService.locale,
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          home: const MyHomePage(),
        ),
      ),
    );
  }

  void registerNotification() {
    firebaseMessaging.requestPermission(alert: false);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}

class PushNotification {
  PushNotification(
      {required this.title,
      required this.body,
      required this.datatitle,
      required this.databody});

  String title;
  String body;
  String datatitle;
  String databody;
}
