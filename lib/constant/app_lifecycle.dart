// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:midas/constant/constant_util.dart';
// import 'package:midas/screen/sign_in/sign_in.dart';
// import 'package:midas/storage/local_storage.dart';

// class AppLifecycleObserver extends WidgetsBindingObserver {
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.inactive) {
//       print("inactive state");
//       // DateTime dateTime = DateTime.now();
      
//       // if (dateTime.isBefore(ConstantUtil.loginDateTime)) {

//       // } else {
//       //   LocalStorage.removeToken();
//       //   Get.off(() => const SignInScreen());
//       // }
//     } else if (state == AppLifecycleState.paused) {
//       print("paused state");
//       // ConstantUtil.loginDateTime =
//       //     DateTime.now().add(const Duration(minutes: 1));
//     } else if (state == AppLifecycleState.detached) {
//       print("detatched state");
//     }
//   }
// }
