// import 'package:midas/constant/colors.dart';
// import 'package:flutter/material.dart';

// class LoadingScreen extends StatefulWidget {
//   const LoadingScreen({super.key});

//   @override
//   State<LoadingScreen> createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//   var height;
//   var width;

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     height = screenSize.height;
//     width = screenSize.width;
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               child: Image.asset('assets/SimpliFin.png'),
//               height: height * 0.3,
//             ),
//             // SizedBox(height: 85),
//             // Padding(
//             //   padding: EdgeInsets.only(
//             //     left: width * 0.12,
//             //     right: width * 0.12,
//             //   ),
//             //   child: ClipRRect(
//             //     borderRadius: BorderRadius.circular(10),
//             //     child: LinearProgressIndicator(
//             //       value: 0.4,
//             //       backgroundColor: AppColors.white,
//             //       valueColor: AlwaysStoppedAnimation<Color>(AppColors.grey),
//             //       minHeight: 10,
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
