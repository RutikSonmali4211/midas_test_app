import 'package:fluttertoast/fluttertoast.dart';
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
