import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';

// Future<void> showSuccessAlert(String message) async{
//   Get.showSnackbar(GetSnackBar(backgroundColor: AppColors.green,message: message,duration: const Duration(seconds: 2),));
// }

// Future<void> showErrorAlert(String message) async{
//  Get.showSnackbar(GetSnackBar(backgroundColor: AppColors.lightRed,message: message,duration: const Duration(seconds: 2)));
// }

Future<void> showSuccessAlert(String message) async {
  await Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.green,
      textColor: AppColors.white,
      gravity: ToastGravity.TOP,
      webPosition: "top",
      timeInSecForIosWeb: 60);
}

Future<void> showErrorAlert(String message) async {
  await Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.lightRed,
      textColor: AppColors.white,
      gravity: ToastGravity.TOP,
      webPosition: "top",
      timeInSecForIosWeb: 60);
}

void showErrorDialogBox(String errorMessage) {
  Get.dialog(
    AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Error',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back(); 
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: Text(
        errorMessage,
        style: const TextStyle(fontSize: 18.0),
      ),
    ),
  );
}


// void showErrorDialogBox(BuildContext context, String errorMessage) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         insetPadding: const EdgeInsets.all(40),
//         backgroundColor: AppColors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Error',
//               style: TextStyle(color: AppColors.primary),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Icon(Icons.close),
//             ),
//           ],
//         ),
//         content: Text(errorMessage),
//       );
//     },
//   );
// }
