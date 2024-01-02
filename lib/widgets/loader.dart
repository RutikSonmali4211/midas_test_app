import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {

  static void showLoading([String? message]) {
    Get.dialog(
      barrierDismissible: false,
      const Center(child: CircularProgressIndicator())
    );
  }

  static void hideLoading() {
    if(Get.isDialogOpen!){
      Get.back();
    }
  }

  static Future<void> showLoadingNew(GlobalKey key) async {
    return showDialog<void>(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

   static Future<void> hideLoadingIndicator(GlobalKey key) async {
    try {
      Navigator.of(key.currentContext!).pop();
    } catch (error) {
      print(error);
    }
  }
}