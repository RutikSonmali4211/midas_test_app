// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:midas/constant/constant_util.dart';
// import 'package:midas/exception/custom_exception.dart';
// import 'package:midas/logs/Loggers.dart';
// import 'package:midas/service/contact_us/contact_us_service.dart';
// import 'package:midas/widgets/alert_message/snackbar.dart';
// import 'package:midas/widgets/loader.dart';

// class ContactUsController extends GetxController {
//   final ContactUsService contactUsService = ContactUsService();

//   Future<bool> addNewContactRequest(
//       String contactUsCategory, String details, BuildContext context) async {
//     try {
//       Loader.showLoading();
//       if (!await ConstantUtil.isInternetConnected()) {
//         throw CustomException(ConstantUtil.internetUnavailable);
//       }
//       var response = await contactUsService.addNewContactRequest(
//           contactUsCategory, details, context);
//       var jsonResponse = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         showSuccessAlert(jsonResponse['message']);
//         return true;
//       } else if (response.statusCode >= 500) {
//         await Loggers.printLog(ContactUsController, "ERROR",
//             "error in add contact us details ${jsonResponse['message']}");
//         return false;
//       } else {
//         showErrorAlert(jsonResponse['message']);
//         return false;
//       }
//     } catch (e) {
//       if (e is CustomException) {
//         showErrorAlert(e.toString());
//       }
//       return false;
//     } finally {
//       Loader.hideLoading();
//     }
//   }
// }
