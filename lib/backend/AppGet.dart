import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppGet extends GetxController {
  static AppGet get to => Get.find<AppGet>();
  var dissmis = EasyLoading.dismiss();
  int userorpharm = 0;
  int logornot = 0;
  int qty = 0;
  var total = 0.0;
  var totalOrders = 0.0;
  var totalnotificationcounterget = 0.obs;
  var notificationcounts = 0.obs;
  int notificationcount = 0;
  // var fcmToken = ''.obs;
  var lanid = 'English'.obs;
  String fcmToken = '';

  var totatlPrice = 0.0.obs;
  var price = 0.0.obs;

  var orderTotalPrice = 0.0.obs;
  var priceOrder = 0.0.obs;

  var tokenuser = '';
  var pass = '';
  var email = '';
  var isVerf = '';
  var tokentype = '';
  

  String catId = '';
  String catName = '';
  String userNaame = '';

  String searchName = '';
  String searchCatId = '';
  String searchPhrmId = '';

  List catIds = [];
  List catNames = [];

  var searchResults = [].obs;

  var category = [].obs;

  var allResults = [].obs;
  var resultsList = [].obs;

  var userMap = <String, dynamic>{}.obs;
  var pharmacyMap = <String, dynamic>{}.obs;
  var usersMap = <String, dynamic>{}.obs;


  var pharmOrderItems = [];
  var cartItemId = '';
  var pharmId = '';
  var orderId = '';

  var cartList = [].obs;
  var pharmPro = [].obs;
  var favList = [].obs;
  var orderList;
  var ordersList = [].obs;

  var pastOrdersMap = <String, dynamic>{}.obs;

  setPharmacyMap(Map<String, dynamic> map) {
    this.pharmacyMap.value = map;
  }

  addCategory(String catadd) {
    category.add(catadd);
    update();
  }

  searchResultsList() {
    List showResults = [];

    if (searchName != "") {
      for (var medSnapshot in allResults) {
        var title = medSnapshot['medicineName'].toLowerCase();
        print(title);
        if (title.contains(searchName.toLowerCase())) {
          showResults.add(medSnapshot);
        }
      }
    } else if (searchCatId.isNotEmpty) {
      for (var medSnapshot in allResults) {
        var catId = medSnapshot['categoryId'].toLowerCase();
        if (catId.contains(searchCatId.toLowerCase())) {
          showResults.add(medSnapshot);
        }
      }
    } else if (searchPhrmId.isNotEmpty) {
      for (var medSnapshot in allResults) {
        var pharmId = medSnapshot['pharmaceyId'].toLowerCase();

        if (pharmId.contains(searchPhrmId.toLowerCase())) {
          showResults.add(medSnapshot);
        }
      }
    } else {
      showResults = List.from(allResults);
    }

    resultsList.value = showResults;
  }

  all() {
    searchResultsList();
    update();
  }

  totalAmount(double price, int quantity) {
    total += price * quantity;
    print(total);
    return total;
  }

  totalAmountPharm(double price, int quantity){
    totalOrders += price * quantity;
    print(totalOrders);
    return totalOrders;
  }

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future getImages(ImageSource imageSource) async {
    // print(imageSource.toString());
    final XFile? pickedFile = await _picker.pickImage(
        source: imageSource, maxHeight: 200, maxWidth: 200, imageQuality: 100);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      selectedImageSize.value =
          ((File(selectedImagePath.value).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2)) +
              " Mb";
    } else {

      Get.snackbar(
        'error'.tr,
        'noimageselected'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

    }
  }
  updateOrderStatus(){
     
  }
}
