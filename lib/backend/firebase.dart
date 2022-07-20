import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:drug_delivery_application/backend/AppGet.dart';
import 'package:drug_delivery_application/screens/pharmacey/PharmNavBar/PharmNavBar.dart';
import 'package:drug_delivery_application/screens/user/UserNavBar/UserNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../screens/onboarding/onboarding2.dart';
import '../screens/pharmacey/PharmSignUp/verfiyEmail.dart';
import '../screens/user/AddAddress/AddAddress.dart';

final AppGet appGet = Get.put(AppGet());

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child("userNames");
FieldValue timestamp = FieldValue.serverTimestamp();

var uuid = const Uuid();
var v4 = uuid.v4();

String userIds = "";
String userNames = "";

String usersCollectionName = 'Users';
String pharmaciesCollectionName = 'Pharmacies';
String pharmaciesProductsCollectionName = 'Products';
String categoriesCollectionName = 'categories';
String cartCollection = 'cart';
String ordersCollection = 'orders';
String favouriteCollection = 'Favourite';
String chatCollectionName = 'chat';
String userRateCollectionName = 'rates';
String pastOrdersCollection = 'pastOrders';
String notificationCollection = 'Notification';
String pharmId = 'userId';
savetoken(String token, int type, String password) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final keyPharmacyorUser = 'type';
  final pass = 'password';
  final email = 'email';
  final value = token;
  final valtyp = type;
  final valuePass = pass;
  final valemail = email;

  appGet.tokenuser = token;
  appGet.tokentype = type.toString();
  appGet.pass = pass.toString();
  appGet.email = email.toString();
  
  await prefs.setString(key, value);
  await prefs.setString(pass, valuePass);
  await prefs.setString(email, valemail);

  await prefs.setString(keyPharmacyorUser, valtyp.toString());
  print('trpesave' + appGet.tokentype.toString());
  print('tokensave' + appGet.tokenuser.toString());
  print('tokensave' + appGet.email.toString());
}

kiltoken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = 'token';
  final type = 'type';
  final pass = 'password';
  final email = 'email';
  final value = 'null';
  appGet.tokenuser = '';
  appGet.tokentype = '';
  appGet.pass = '';
  appGet.email = '';
  await prefs.setString(token, value);
  await prefs.setString(type, value);
  await prefs.setString(pass, value);
  await prefs.setString(email, value);
  print('trpekill' + appGet.tokentype.toString());
  print('tokenkill' + appGet.tokenuser.toString());
  print('tokenkill' + appGet.pass.toString());
  print('tokenkill' + appGet.email.toString());
}

gettoken() async {
  var tokens;
  var typ;
  var pass;
  var emai;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  tokens = prefs.get('token');
  typ = prefs.get('type');
  pass = prefs.get('password');

  emai = prefs.get('email');
  appGet.tokenuser = tokens.toString();
  appGet.tokentype = typ.toString();
  userIds = tokens.toString();
  appGet.pass = pass.toString();
  appGet.email = emai.toString();



  print('trpesmo' + appGet.tokentype.toString());
  print('tokenmo' + appGet.tokenuser.toString());
  print('tokenmo' + appGet.pass.toString());
  print('tokenmo' + appGet.email.toString());
  if (appGet.tokenuser.toString() == 'null') {
    Get.offAll(() => const Onboarding2());
  } else {
    if (appGet.tokentype == '1') {
      Get.offAll(() => const UserNavBar());
      getUserFromFirestore(userId: appGet.tokenuser, pass: appGet.pass);
    } else if (appGet.tokentype == '2') {
      Get.offAll(() => const PharmNavBar());
      getPharmFromFirestore(userId: appGet.tokenuser, pass: appGet.pass);
    }
    userIds = appGet.tokenuser;

  }
}

Future<Map?> signInWithEmailAndPassword(
    {required String email,
    required String password,
    required int userOrPhram}) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (userCredential != null) {
      userIds = userCredential.user!.uid;

      Map map;
      if (userOrPhram == 1) {
        map = await getUserFromFirestore(userId: userIds, pass: password);
        appGet.userorpharm = 1;
      } else {
        map = await getPharmFromFirestore(userId: userIds, pass: password);
        appGet.userorpharm = 2;
      }
      if (appGet.logornot == 1) {
      } else {
        userOrPhram == 1
            ? Get.offAll(() => const UserNavBar())
            : Get.offAll(() => const PharmNavBar());
        appGet.dissmis;
      }
      return map;
    } else {
      EasyLoading.showError('Failed');

      return null;
    }
  } on FirebaseAuthException catch (e) {
    appGet.dissmis;
    if (e.code == 'user-not-found') {
      EasyLoading.showError('invaildemail'.tr);
    } else if (e.code == 'wrong-password') {
      EasyLoading.showError('invaildpassword'.tr);
    }
    return null;
  } catch (e) {
    appGet.dissmis;
    EasyLoading.showError(e.toString());
    return null;
  }
}

Future<Map<String, dynamic>> getUserFromFirestore(
    {required String userId, required String pass}) async {
  print(userIds.toString());
  DocumentSnapshot documentSnapshot =
      await firestore.collection(usersCollectionName).doc(userIds).get();
  Map<String, dynamic>? response =
      documentSnapshot.data() as Map<String, dynamic>;
  print('this i need' + response.toString());
  if (response == null) {
    appGet.logornot = 1;
  } else {
    savetoken(userIds, 1, pass);
  }
  appGet.userMap.value = response;
  appGet.usersMap.value = response;
  print('this i map' + appGet.userMap.toString());
  return response;
}

Future<Map<String, dynamic>> getPharmFromFirestore(
    {required String userId, required String pass}) async {
  print(userIds.toString());
  DocumentSnapshot documentSnapshot =
      await firestore.collection(pharmaciesCollectionName).doc(userIds).get();
  Map<String, dynamic>? response =
      documentSnapshot.data() as Map<String, dynamic>;
  print('this i need' + response.toString());
  if (response == null) {
    appGet.logornot = 1;
  } else {
    savetoken(userIds, 2, pass);
  }
  appGet.pharmacyMap.value = response;
    appGet.usersMap.value = response;

  print('this i map' + appGet.pharmacyMap.toString());
  return response;
}

var verfied;
Future<String?> registerUsingEmailAndPassword({
  required String email,
  required String password,
}) async {
  print(email + 'pass:=' + password);

  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    var user = userCredential.user;
    verfied = user?.sendEmailVerification();
    print(userCredential.user!.uid);
    if (userCredential != null) {
      String userId = userCredential.user!.uid;
      savetoken(userId, 1, password);
      return userId;
    } else {
      EasyLoading.showError('failed'.tr);

      return null;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      appGet.dissmis;
      EasyLoading.showError('weakpassword'.tr);
    } else {
      appGet.dissmis;
      EasyLoading.showError(e.code);
    }
    return null;
  } catch (e) {
    EasyLoading.showError(e.toString());
    return null;
  }
}

Future registrationProcess(
    {String? name,
    required String email,
    required String password,
    required String mobile,
    required String address,
    required bool isUser,
    String? pharmName,

    String? openHours}) async {
  try {
    saveUserNameInRealtimeDb(userName: email);

    String? userId =
        await registerUsingEmailAndPassword(email: email, password: password);

    print(userId);
    if (userId == null) {
      throw ('register_failed');
    } else {
      userIds = userId;
      bool isSuccess = false;
      if (isUser) {
        isSuccess = await saveUserInFirestore(
            userId: userId,
            name: name!,
            email: email,
            mobile: mobile,
            address: address);
      } else {
        isSuccess = await savePharmacyInFirestore(
            userId: userId,
            email: email,
            mobile: mobile,
            address: address,
            pharmName: pharmName!,
            openHours: openHours!);
      }

      if (isSuccess == true && isUser == true) {

        print('userrrrrrrrrrr');
        getUserFromFirestore(userId: userId, pass: appGet.pass);
        Get.offAll(() => AddAddress(name!, 1));
        // Get.offAll(() => VerfiyEmail(name!, email, 1));
      } else if (isSuccess == true && isUser == false) {
        print('pharmacyrrrrrrrrrr');
        getPharmFromFirestore(userId: userId, pass: appGet.pass);
        // Get.offAll(() => VerfiyEmail(pharmName!, email, 2));
        Get.offAll(() => AddAddress(pharmName!, 2));
      }
      if (isSuccess == false) {
        throw ('Failed Save user in firestore');
      }
    }
  } on Exception catch (e) {
    EasyLoading.showError(e.toString());
  }
}

Future<bool> saveUserInFirestore(
    {required String name,
    required String email,
    required String mobile,
    required String address,
    required String userId}) async {
  try {
    await firestore.collection(usersCollectionName).doc(userId).set({
      'userName': name,
      'email': email,
      'phoneNumber': mobile,
      'address': address,
      'userId': userId,
      'createdDate': timestamp
    });
    appGet.dissmis;
    appGet.userNaame = name;
    return true;
  } on Exception catch (e) {
    appGet.dissmis;
    return false;
  }
}

Future<bool> savePharmacyInFirestore(
    {required String email,
    required String mobile,
    required String address,
    required String userId,
    required String pharmName,
    required String openHours}) async {
  try {
    await firestore.collection(pharmaciesCollectionName).doc(userId).set({
      'email': email,
      'phoneNumber': mobile,
      'address': address,
      'userId': userId,
      'createdDate': timestamp,
      'openHours': openHours,
      'pharmName': pharmName,
      'rating': 0.0
    });
    appGet.dissmis;
     appGet.userNaame = pharmName;
    return true;
  } on Exception catch (e) {
    appGet.dissmis;
    return false;
  }
}

saveUserNameInRealtimeDb({required String userName}) async {
  dbRef.push().set({"userName": userName});
}

Future<String?> uploadIdentityImage(File? file, String? userId) async {
  String msar = Uuid().v1();
  print('msar' + msar);
  print('msaruser' + appGet.tokenuser.toString());
  String downloadUrl = '';
  try {
    final Reference reference =
        FirebaseStorage.instance.ref().child("UserIdentityImages/$msar.png");

    await reference.putFile(file!);

    downloadUrl = await reference.getDownloadURL();

    await FirebaseFirestore.instance
        .collection(usersCollectionName)
        .doc(appGet.tokenuser)
        .update({
      "imageUrl": downloadUrl,
    });

    getUserFromFirestore(userId: appGet.tokenuser, pass: appGet.pass);
    return downloadUrl;
  } on Exception catch (e) {
    return null;
  }
}

Future uploadchatImage(file) async {
  String msar = Uuid().v1();
  print('msar' + msar);
  print('msaruser' + userIds.toString());
  String downloadUrl = '';
  try {
    final Reference reference =
        FirebaseStorage.instance.ref().child("chatImages/$msar.png");

    await reference.putFile(File(file));

    downloadUrl = await reference.getDownloadURL();

    // return await reference.getDownloadURL();
  } on Exception catch (e) {
    return null;
  }
  return downloadUrl;
}

Future<String?> uploadImage(File? file, String? userId) async {
  String msar = Uuid().v1();
  print('msar' + msar);
  print('msaruser' + appGet.tokenuser.toString());
  String downloadUrl = '';
  try {
    final Reference reference =
        FirebaseStorage.instance.ref().child("pharmaciesImages/$msar.png");

    await reference.putFile(file!);

    downloadUrl = await reference.getDownloadURL();

    await FirebaseFirestore.instance
        .collection(pharmaciesCollectionName)
        .doc(appGet.tokenuser)
        .update({
      "imageUrl": downloadUrl,
    });

    getPharmFromFirestore(userId: appGet.tokenuser, pass: appGet.pass);
    return downloadUrl;
  } on Exception catch (e) {
    return null;
  }
}

Future sendPasswordResetEmail(String email) async {
  return auth.sendPasswordResetEmail(email: email);
}

Future addAddress(String location) async {
  try {
    firestore.collection(usersCollectionName).doc(appGet.tokenuser).update({
      'address': location,
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future addPharmAddress(String location) async {
  try {
    firestore
        .collection(pharmaciesCollectionName)
        .doc(appGet.tokenuser)
        .update({
      'address': location,
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future addMedicine(
    File image,
    String name,
    String price,
    String? availability,
    String? description,
    String? howToUse,
    String cateid,
    String cateName,
    String pharmName) async {
  try {
    String msar = Uuid().v1();
    String id = Uuid().v4();
    print('msar' + msar);
    print('msaruser' + appGet.tokenuser.toString());
    String downloadUrl = '';

    final Reference reference =
        FirebaseStorage.instance.ref().child("medicinesImages/$msar.png");

    await reference.putFile(image);

    downloadUrl = await reference.getDownloadURL();

    await firestore.collection(pharmaciesProductsCollectionName).doc().set({
      'medicineImage': downloadUrl,
      'medicineName': name,
      'medicinePrice': price,
      'medicineAvailability': availability,
      'medicineDescription': description,
      'medicineHowToUse': howToUse,
      'pharmaceyId': appGet.tokenuser,
      'createdDate': timestamp,
      'medicineId': id,
      'categoryId': cateid,
      'categoryName': cateName,
      'pharmName': pharmName
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future getCategories() async {
  appGet.catNames.clear();
  appGet.catIds.clear();
  var documentSnapshot =
      await firestore.collection(categoriesCollectionName).get();
  documentSnapshot.docs.forEach((document) {
    if (document['catId'] != null) {
      print(document['catId'].toString());
      appGet.catId = document['catId'].toString();
      appGet.catIds.add(appGet.catId);
    }
    if (document['catName'] != null) {
      print(document['catName'].toString());
      appGet.catName = document['catName'].toString();
      appGet.catNames.add(appGet.catName);
    }
  });
  print(appGet.catNames.toString());
  return true;
}

Stream<QuerySnapshot>? getAllCategories() {
  try {
    Stream<QuerySnapshot> stream =
        firestore.collection(categoriesCollectionName).snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}

Stream<QuerySnapshot>? getAllPharmacies() {
  try {
    Stream<QuerySnapshot> stream =
        firestore.collection(pharmaciesCollectionName).snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}

Stream<QuerySnapshot>? getAllCategoriesMedications(String categoryId) {
  try {
    Stream<QuerySnapshot> stream = firestore
        .collection(pharmaciesProductsCollectionName)
        .where('categoryId', isEqualTo: categoryId)
        .snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}

Stream<QuerySnapshot>? getAllCategoriesMedicationsByPharm(
    String categoryId, String pharmId) {
  try {
    Stream<QuerySnapshot> stream = firestore
        .collection(pharmaciesProductsCollectionName)
        .where('categoryId', isEqualTo: categoryId)
        .where('pharmaceyId', isEqualTo: pharmId)
        .snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}

Future getMedicationsByPharm(String pharmId) async {
  try {
    var data = await firestore
        .collection(pharmaciesProductsCollectionName)
        .where('pharmaceyId', isEqualTo: pharmId)
        .get();

    print(data.docs);
    print(userIds);
    appGet.pharmPro.value = data.docs;

    print(appGet.pharmPro.toList());
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future addToCart(
  String imageUrl,
  String name,
  String price,
  String? availability,
  String? description,
  String? howToUse,
  String cateid,
  String cateName,
  String qty,
  String totalPrice,
  String medicineId,
  String pharmId,
  String pharmname,
) async {
  try {
    String id = Uuid().v4();
    print('msaruser' + appGet.tokenuser.toString());

    await firestore.collection(cartCollection).doc().set({
      'userId': userIds,
      'medicineImage': imageUrl,
      'medicineName': name,
      'medicinePrice': price,
      'medicineAvailability': availability,
      'medicineDescription': description,
      'medicineHowToUse': howToUse,
      'pharmaceyId': pharmId,
      'createdDate': timestamp,
      'medicineId': medicineId,
      'categoryId': cateid,
      'categoryName': cateName,
      'quntity': qty,
      'totalPrice': totalPrice,
      'pharmName': pharmname,
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future checkCartItem(medicineId) async {
  try {
    print(medicineId.toString());
    await firestore
        .collection(cartCollection)
        .where('medicineId', isEqualTo: medicineId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        appGet.cartItemId = documentData['medicineId'].toString();
        appGet.pharmId = documentData['pharmaceyId'].toString();
      } else {}
    }).catchError((e) => print("error fetching data: $e"));

    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future getUserCart() async {
  try {
    var data = await firestore
        .collection(cartCollection)
        .where('userId', isEqualTo: userIds)
        .get();

    print(data.docs);
    print(userIds);
    appGet.cartList.value = data.docs;

    print(appGet.cartList.toList());
    return true;
  } on Exception catch (e) {
    return false;
  }
}

// Future getUserOrders(String pharmId) async {
//   try{
//     var data = await firestore
//     .collection(ordersCollection)
//     .where('pharmId', isEqualTo: pharmId)
//     .get().forEach(())



//   }
// }
Future updateqty(String qty, String medId) async {
  try {
    firestore
        .collection(cartCollection)
        .where('medicineId', isEqualTo: medId)
        .get()
        .then((value) => value.docs.forEach((doc) {
              doc.reference.update({
                'quntity': qty,
              });
            }));
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future updateAddress(String address) async {
  try {
    await FirebaseFirestore.instance
        .collection(usersCollectionName)
        .doc(userIds)
        .update({
      "address": address,
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future addToFavourite(
    String imageUrl,
    String name,
    String price,
    String availability,
    String description,
    String howToUse,
    String cateid,
    String cateName,
    String medicineId,
    String pharmId,
    String pharmname) async {
  try {
    await firestore.collection(favouriteCollection).doc().set({
      'userId': userIds,
      'medicineImage': imageUrl,
      'medicineName': name,
      'medicinePrice': price,
      'medicineAvailability': availability,
      'medicineDescription': description,
      'medicineHowToUse': howToUse,
      'pharmaceyId': pharmId,
      'createdDate': timestamp,
      'medicineId': medicineId,
      'categoryId': cateid,
      'categoryName': cateName,
      'pharmName': pharmname
    });
    return true;
  } on Exception catch (e) {
    print(e);
    return false;
  }
}

Future removeFromFav(String medId) async {
  try {
    final firstore = FirebaseFirestore.instance;
    firstore
        .collection(favouriteCollection)
        .where('medicineId', isEqualTo: medId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        print(ds.reference);
      }
    });

    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future getAllFavourite() async {
  try {
    var data = await firestore
        .collection(favouriteCollection)
        .where('userId', isEqualTo: userIds)
        .get();

    print(data.docs);
    print(userIds);
    appGet.favList.value = data.docs;

    print(appGet.favList.toList());
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future updateUserData(String name) async {
  try {
    FirebaseFirestore.instance
        .collection(usersCollectionName)
        .doc(userIds)
        .update({
      "userName": name,
    });

    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future updatePharmData(String name) async {
  try {
    FirebaseFirestore.instance
        .collection(pharmaciesCollectionName)
        .doc(userIds)
        .update({
      "pharmName": name,
    });

    return true;
  } on Exception catch (e) {
    return false;
  }
}
Future ratePharm(double rating, String pharmId) async {
  try {
    await FirebaseFirestore.instance
        .collection(pharmaciesCollectionName)
        .doc(pharmId)
        .update({
      "rating": rating,
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future deleteCartItem(String medId) async {
  try {
    final firstore = FirebaseFirestore.instance;
    firstore
        .collection(cartCollection)
        .where('medicineId', isEqualTo: medId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        print(ds.reference);
      }
    });

    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future deleteOrder(String orderNum) async{
  try {
    final firstore = FirebaseFirestore.instance;
    firstore
        .collection(cartCollection)
        .where('orderNumber', isEqualTo: orderNum)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        print(ds.reference);
      }
    });

    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future deleteProduct(String medicineId) async{
  try {
    final firstore = FirebaseFirestore.instance;
    firstore
        .collection(pharmaciesProductsCollectionName)
        .where('medicineId', isEqualTo: medicineId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        print(ds.reference);
      }
    });

    return true;
  } on Exception catch (e) {
    return false;
  }
}


Stream<QuerySnapshot>? getchatlist() {
  try {
    Stream<QuerySnapshot> stream = firestore
        .collection(chatCollectionName)
        .where('users', arrayContains: userIds)
        .snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}



Future<String> updatchatstatuse(String docid) async {
  print(docid);
  await FirebaseFirestore.instance
      .collection(chatCollectionName)
      .doc(docid)
      .update({
    "state": '2',
  });
  return 'true';
}

Stream<QuerySnapshot>? getmychat(String userrecive) {
  print('typsuserreciveuserrecive' + userrecive);
  print('typsuserreciveusendddddddd' + userIds);
  String chtr = '';

  chtr = getChatRoomId(userIds, userrecive);

  print('chtruser' + chtr);
  try {
    Stream<QuerySnapshot> stream = firestore
        .collection(chatCollectionName)
        .doc(chtr)
        .collection("chats")
        .orderBy('time')
        .snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}

getChatRoomId(String a, String b) {
  print('ssssss' + a);
  print('hhhhhhh' + b);
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

Future onFileUploadButtonPressed(String filePath) async {
  print('filePathnnnnn' + filePath);
  FirebaseStorage firebaseStoragen = FirebaseStorage.instance;
  String downloadUrl = '';
  try {
    final Reference reference4 = firebaseStoragen
        .ref('upload-voice-firebase')
        .child(filePath.substring(filePath.lastIndexOf('/'), filePath.length));
    await reference4.putFile(File(filePath)).whenComplete(() async {
      downloadUrl = await reference4.getDownloadURL();
      print('mmmaamm' + downloadUrl);
    });
    onUploadComplete();
  } catch (error) {
    print('Error occured while uplaoding to Firebase ${error.toString()}');
  } finally {}
  return downloadUrl;
}

List<Reference> references = [];
Future<void> onUploadComplete() async {
  ListResult listResult =
      await firebaseStorage.ref().child('upload-voice-firebase').listAll();

  references = listResult.items;
  print(references.toString());
}

Future<bool> savechatFirestore(
  String mosName,
  String usermostakbleid,
  String detailes,
  bool islocation,
  double lat,
  double lon,
  String soundownload,
  bool issound,
  bool isimage,
  String imgurl,
  String userimgurl,
) async {
  String chatrt;
  print('ussend' + userIds.toString());
  print('usermostakble' + usermostakbleid.toString());

  chatrt = getChatRoomId(userIds, usermostakbleid);

  List<String> users = [usermostakbleid, userIds];
  Map<String, dynamic> chatRoom = {
    "users": users,
    "chatRoomId": chatrt,
    "creatdate": DateTime.now().millisecondsSinceEpoch,
    "useridrecive": usermostakbleid,
    "usersend": userIds,
    "detailes": detailes,
    "state": '1',
    "islocation": islocation,
    "lat": lat,
    "lon": lon,
    "soundownload": soundownload,
    "issound": issound,
    'isimage': isimage,
    'imageurl': imgurl,
    "mostakblename": mosName,
    "morslname": appGet.userNaame,
    "userimage": userimgurl
  };

  addChatRoom(chatRoom, chatrt);

  try {
    FirebaseFirestore.instance
        .collection(chatCollectionName)
        .doc(chatrt)
        .collection("chats")
        .add({
      'detailes': detailes,
      'sendby': userIds,
      "mostakblename": mosName,
      "morslname": appGet.userNaame,
      'time': DateTime.now().millisecondsSinceEpoch,
      'state': '1',
      'delete': 0,
      "islocation": islocation,
      "lat": lat,
      "lon": lon,
      "soundownload": soundownload,
      "issound": issound,
      'isimage': isimage,
      'imageurl': imgurl
    });
    FirebaseFirestore.instance
        .collection(chatCollectionName)
        .doc(chatrt)
        .update({
      'state': '1',
      'detailes': detailes,
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future<bool>? addChatRoom(chatRoom, chatRoomId) {
  FirebaseFirestore.instance
      .collection(chatCollectionName)
      .doc(chatRoomId)
      .set(chatRoom)
      .catchError((e) {
    print(e);
  });
  return null;
}

Future deleteCart() async {
  try {
    final firstore = FirebaseFirestore.instance;
    firstore
        .collection(cartCollection)
        .where('userId', isEqualTo: userIds)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future userReview(String review, double rate) async {
  try {
    await firestore.collection(userRateCollectionName).doc().set({
      'userId': userIds,
      'review': review,
      'rate': rate,
      'createdDate': timestamp,
    });
    return true;
  } on Exception catch (e) {
    print(e);
    return false;
  }
}

Future addOrder(
    String pharmId, String pharmName, String note, int orderStatus) async {
  var rng = new Random();
  var code = rng.nextInt(9000) + 1000;
  List lolo = [];
  print(appGet.cartList[0]['medicineName']);
  for (var ii = 0; ii < appGet.cartList.length; ii++) {
    lolo.add({
      'categoryId': appGet.cartList[ii]['categoryId'],
      'categoryName': appGet.cartList[ii]['categoryName'],
      'createdDate': appGet.cartList[ii]['createdDate'],
      'medicineAvailability': appGet.cartList[ii]['medicineAvailability'],
      'medicineDescription': appGet.cartList[ii]['medicineDescription'],
      'medicineHowToUse': appGet.cartList[ii]['medicineHowToUse'],
      'medicineId': appGet.cartList[ii]['medicineId'],
      'medicineImage': appGet.cartList[ii]['medicineImage'],
      'medicineName': appGet.cartList[ii]['medicineName'],
      'medicinePrice': appGet.cartList[ii]['medicinePrice'],
      'pharmName': appGet.cartList[ii]['pharmName'],
      'pharmaceyId': appGet.cartList[ii]['pharmaceyId'],
      'quntity': appGet.cartList[ii]['quntity'],
      'totalPrice': appGet.cartList[ii]['totalPrice'],
      'userId': appGet.cartList[ii]['userId'],
    });
  }
  print(lolo);
  try {
    await firestore.collection(ordersCollection).doc().set({
      'orderNumber': code,
      'address': appGet.userMap['address'],
      'userName': appGet.userMap['userName'],
      'userId': userIds,
      'userPhone': appGet.userMap['phoneNumber'],
      'useremail': appGet.userMap['email'],
      'pharmId': pharmId,
      'phamName': pharmName,
      'note': note,
      'orderStatus': orderStatus,
      // ignore: invalid_use_of_protected_member
      'items': lolo,
      'createdDate': DateTime.now().millisecondsSinceEpoch,
      'deliveryDate': DateTime.now().millisecondsSinceEpoch
    });
    appGet.orderId = code.toString();
    return true;
  } on Exception catch (e) {
    print(e);
    return false;
  }
}

Future getUserOrder(String orderID) async {
  try {
    var data = await firestore
        .collection(ordersCollection)
        .where('orderNumber', isEqualTo: int.parse(orderID))
        .get();

    print(data.docs);
    print(userIds);
    appGet.orderList = data.docs;

    print(appGet.orderList);

    print(appGet.orderId);
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future updateOrderStatus(int status, String ordernumber) async {
  try {
    firestore
        .collection(ordersCollection)
        .where('orderNumber', isEqualTo: int.parse(ordernumber))
        .get()
        .then((value) => value.docs.forEach((doc) {
              doc.reference.update({
                'orderStatus': status,
                'deliveryDate': DateTime.now().millisecondsSinceEpoch,
              });
            }));
    return true;
  } on Exception catch (e) {
    return false;
  }
}
Future updateProductAvailability(String status, String medId) async {
  try {
    firestore
        .collection(pharmaciesProductsCollectionName)
        .where('medicineId', isEqualTo: medId)
        .get()
        .then((value) => value.docs.forEach((doc) {
              doc.reference.update({
                'medicineAvailability': status,
              });
            }));
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Stream<QuerySnapshot>? pastOrders(String idd) {
  try{
     Stream<QuerySnapshot> stream = firestore
        .collection(ordersCollection)
        .where('pharmId', isEqualTo: idd)
        .where('orderStatus', isEqualTo:  int.parse('4'))
        .snapshots();
        return stream;      
  } on Exception catch(e){
   return null;
  }
}

// Future getUserOrders() async {
//   try {
//     var data = await firestore
//         .collection(ordersCollection)
//         .where('userId', isEqualTo: userIds)
//         .get();

//     print(data.docs);
//     print(userIds);
//     appGet.ordersList.value = data.docs;

//     print(appGet.ordersList.toList());

//     return true;
//   } on Exception catch (e) {
//     return false;
//   }
// }

Stream<QuerySnapshot>? getUserOrders() {
  try {
    Stream<QuerySnapshot> stream = firestore
        .collection(ordersCollection)
        .where('userId', isEqualTo: userIds)
        .snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}

sendTofcm(
  String title,
  String body,
  String fcmToken,
  String ordernum,
) async {
  print('mndobbfcm' + fcmToken.toString());
  final data = {
    "notification": {"body": "$body", "title": "$title", "sound": "default"},
    "priority": "high",
    "data": {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "ordernum": 'sp'
    },
    "to": "$fcmToken"
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
        'key=AAAA9Dg0MNo:APA91bEWwu3XOr1bk9AIeUv6GaCa3R6uztyJyGaef5pHlN7Zbym1qXstUjWyq9naDbfAR8u38SxvKIzfx7THIt3MGAKa9OWL3y44VQ5KuwbEGasHNJ_mQoHotjZHxFyHb-hQCsusePyh'
  };

  BaseOptions options = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: headers,
  );
  try {
    final response = await Dio(options)
        .post('https://fcm.googleapis.com/fcm/send', data: data);

    if (response.statusCode == 200) {
      print('notification sending success');
    } else {
      print('notification sending failed');
      // on failure do sth
    }
  } catch (e) {
    print('exception $e');
  }

  savnotification(appGet.fcmToken, '1', title, ordernum, body);
  print(title);
  print(body);
  print('send' + fcmToken);
  // return val.toString();
}

Future<bool> savnotification(
  String fcmorder,
  String status,
  String detailes,
  String oderid,
  String body,
) async {
  FieldValue timestamp = FieldValue.serverTimestamp();
  try {
    await firestore.collection(notificationCollection).add({
      'fcmorder': fcmorder,
      'title': detailes,
      'status': status,
      'userId': userIds,
      'datecreate': timestamp,
      'oderid': oderid,
      'delete': 0,
      'body': body,
    });
    return true;
  } on Exception catch (e) {
    return false;
  }
}

getnotification() async {
  try {
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection(notificationCollection)
        .where('status', isEqualTo: '1')
        .where('userId', isEqualTo: userIds)
        .get();
    appGet.notificationcount = qSnap.docs.length;
    appGet.notificationcounts.value = qSnap.docs.length;

    print('notificationscount' + appGet.notificationcount.toString());
  } on Exception catch (e) {
    return null;
  }
}

Stream<QuerySnapshot>? getNotificationsStream() {
  print('allnotification');
  try {
    Stream<QuerySnapshot> stream = firestore
        .collection(notificationCollection)
        .where('userId', isEqualTo: userIds)
        .orderBy('datecreate', descending: true)
        .snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}
Stream<QuerySnapshot>? getAllorders(String pharmId){

  try{
    Stream<QuerySnapshot> stream = firestore 
    .collection(ordersCollection)
    .where('pharmId', isEqualTo: pharmId)
    .where('orderStatus' ,isEqualTo:int.parse('1') )
    .snapshots();

    return stream;
  } on Exception catch(e){
    return null;
  }
}

// Stream<QuerySnapshot>? getPastOrders(String pharmId){
//     try{
//     Stream<QuerySnapshot> stream = firestore 
//     .collection(pastOrdersCollection)
//     .where('pharmId', isEqualTo: pharmId)
//     .snapshots();
   
//    appGet.pastOrdersMap.value = stream as Map<String, dynamic>;
//     return stream;
//   } on Exception catch(e){
//     return null;
//   }
// }

Stream<QuerySnapshot>? getPharmAllCategoriesMedications(String categoryId , String pharmId) {
  try {
    Stream<QuerySnapshot> stream = firestore
        .collection(pharmaciesProductsCollectionName)
        .where('categoryId', isEqualTo: categoryId )     
        .where('pharmaceyId', isEqualTo: pharmId)
        .snapshots();
    return stream;
  } on Exception catch (e) {
    return null;
  }
}
Stream<QuerySnapshot>? getAllProducts(String pharmId){
  try{
    Stream<QuerySnapshot> stream = 
      firestore.collection(pharmaciesProductsCollectionName)
      .where('pharmaceyId', isEqualTo:pharmId)
      .snapshots();
      return stream;
  } on Exception catch(e){
    return null;
  }
}

// Future getOrderDetails(String pharmId, String orderNum) async {
//   try{
//     var data = await firestore.collection(ordersCollection)
//       .where('pharmId', isEqualTo: pharmId)
//       .where('orderNumber' , isEqualTo: int.parse(orderNum))
//        .get();
//       appGet.pharmOrderItems = data.docs.k;
//           return true;

//   } on Exception catch(e) {
//     e.printError();
//     return false;
//   }  
// }


Future addtoPastOrders(String pharmId, String orderNum) async {
  try{
  var data =  await firestore.collection(ordersCollection)
  .where('pharmId', isEqualTo: pharmId)
   .where('orderNumber' , isEqualTo: int.parse(orderNum))
  .get();

     
  appGet.pastOrdersMap.value = data.docs as RxMap<String, dynamic>;
   
}
 on Exception catch(e) {
    e.printError();
    return false;
  }  

}