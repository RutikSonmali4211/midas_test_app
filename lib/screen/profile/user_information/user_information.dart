// import 'package:get/get.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';
// import 'package:midas/controller/user/user_controller.dart';
// import 'package:midas/widgets/appbar/small_appbar.dart';

// class UserInformationScreen extends StatefulWidget {
//   const UserInformationScreen({super.key});

//   @override
//   State<UserInformationScreen> createState() => _UserInformationScreenState();
// }

// class _UserInformationScreenState extends State<UserInformationScreen> {
//   var height;
//   var width;

//   bool istoggle = true;

//   UserController userController= Get.find();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     height = size.height;
//     width = size.width;
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SmallAppbar(heading: "User Information"),
//           SizedBox(height:  SizeUtil.verticalSpacingMedium(context)),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left: size.width * 0.04,
//                   right: size.width * 0.04),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Personal Details",
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontSize: SizeUtil.bodyLarge(context),
//                             fontWeight: FontWeight.w700,
//                             fontFamily: "Helvetica",
//                           ),
//                         ),
//                         SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Name',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                    userController.user.value!=null ?userController.user.value!.name.toString():"",
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             Expanded(
//                               flex: 6,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Phone Number',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     userController.user.value!=null ?userController.user.value!.mobileNumber.toString():"",
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Date of Birth',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     "-",
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             Expanded(
//                               flex: 6,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Email',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                    userController.user.value!=null ?userController.user.value!.email.toString():"",
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height:  SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Divider(
//                         height: 10,
//                         color: AppColors.lightgrey,
//                         thickness: 1,
//                         indent: 0,
//                         endIndent: 0,
//                       ),
//                     ),
//                     SizedBox(
//                       height:  SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Identification",
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontSize: SizeUtil.bodyLarge(context),
//                             fontWeight: FontWeight.w700,
//                             fontFamily: "Helvetica",
//                           ),
//                         ),
//                         SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'PAN',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     userController.user.value!=null ?userController.user.value!.pan.toString():"",
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             Expanded(
//                               flex: 6,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Nationality',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     'IND',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Tax Residency',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     'IND',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height:  SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Divider(
//                         height: 10,
//                         color: AppColors.lightgrey,
//                         thickness: 1,
//                         indent: 0,
//                         endIndent: 0,
//                       ),
//                     ),
//                     SizedBox(
//                       height:  SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Address",
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontSize: SizeUtil.bodyLarge(context),
//                             fontWeight: FontWeight.w700,
//                             fontFamily: "Helvetica",
//                           ),
//                         ),
//                         SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Address 1',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     '-',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 6,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Address 2',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     '-',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'City',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     '-',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             Expanded(
//                               flex: 6,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'State',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     '-',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: SizeUtil.verticalSpacingMedium(context),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'PIN Code',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                   Text(
//                                     '-',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                           SizedBox(
//                           height:  SizeUtil.verticalSpacingMedium(context),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
