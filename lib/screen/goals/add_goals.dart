// // ignore_for_file: use_build_context_synchronously

// import 'package:get/get.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/controller/goals/goals_controller.dart';
// import 'package:midas/screen/notifications/notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../constant/sizeConstant.dart';
// import '../../constant/size_util.dart';
// import '../profile/profile_and_setting.dart';
// import 'goals.dart';
// import 'package:midas/Widgets/buttons/small_button.dart';

// class AddGoalItem extends StatefulWidget {
//   final bool isEdit;
//  final bool isWatch;
//  final String goalId;
//   final String goalName;
//   final String goalValue;
//   final DateTime goalTargetDate;
//   final String description;
//   const AddGoalItem({
//     super.key,
//     required this.goalId,
//     required this.goalName,
//     required this.goalValue,
//     required this.goalTargetDate,
//     required this.description,
//     required this.isEdit,
//     required this.isWatch,
//   });

//   @override
//   State<AddGoalItem> createState() => _AddGoalItemState();
// }

// class _AddGoalItemState extends State<AddGoalItem> {
//   final FocusNode goalNameFocusNode = FocusNode();
//   final FocusNode goalValueFocusNode = FocusNode();
//   final FocusNode goalTargetDateFocusNode = FocusNode();
//   final FocusNode descriptionFocusNode = FocusNode();
//   final TextEditingController goalNameController = TextEditingController();
//   final TextEditingController goalValueController = TextEditingController();
//   final TextEditingController goalTargetDateController =
//       TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   Future<void> _selectgoalTargetDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now()) {
//       setState(() {
//         goalTargetDateController.text =
//             "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
//       });
//     }
//   }

//   TextEditingController goldTypeController = TextEditingController();
//   GlobalKey<FormState> addGoalsFormKey = GlobalKey<FormState>();

//   GoalsController goalsController = Get.put(GoalsController());

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit || widget.isWatch) {
//       goalNameController.text = widget.goalName;
//       goalValueController.text = widget.goalValue;
//       goalTargetDateController.text = "${widget.goalTargetDate.day.toString().padLeft(2, '0')}/${widget.goalTargetDate.month.toString().padLeft(2, '0')}/${widget.goalTargetDate.year.toString()}";
//       descriptionController.text = widget.description;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(children: [
//         Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.shadow,
//                 offset: Offset(0, 4),
//                 blurRadius: 4.0,
//                 spreadRadius: 2.0,
//               ),
//             ],
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(DefaultSizes.appheadercircularborder),
//               bottomRight:
//                   Radius.circular(DefaultSizes.appheadercircularborder),
//             ),
//             color: AppColors.primary,
//           ),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: SizeUtil.getStatusBarHeight(context), right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       color: AppColors.white,
//                       iconSize: SizeUtil.iconsSize(context),
//                       icon: const Icon(Icons.notifications_outlined),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const Notifications()),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       color: AppColors.white,
//                       icon: const Icon(Icons.account_circle),
//                       iconSize: SizeUtil.iconsSize(context),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const ProfileAndSettings()),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: SizeUtil.verticalSpacingMedium(context),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: addGoalsFormKey,
//                 child: Column(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         RichText(
//                            textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                           textAlign: TextAlign.start,
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Goal ',
//                                 style: TextStyle(
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     color: AppColors.grey),
//                               ),
//                               TextSpan(
//                                   text: "*",
//                                   style: TextStyle(
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       color: AppColors.red)),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 2,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 40.0),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: TextFormField(
//                               autofocus: true,
//                               readOnly: widget.isWatch,
//                               controller: goalNameController,
//                               decoration: const InputDecoration(
//                                 filled: true,
//                                 isDense: true,
//                                 border: InputBorder.none,
//                                 hintText: 'e.g., House',
//                                 hintStyle: TextStyle(color: AppColors.grey),
//                                 fillColor: TextfieldColors.background,
//                               ),
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]'))
//                               ],
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               validator: (value) {
//                                 if (value!.isEmpty &&
//                                     !goalNameFocusNode.hasFocus) {
//                                   return 'goal is required';
//                                 }
//                                 //  else {
//                                 //   if (value.length < 3 &&
//                                 //       !goalNameFocusNode.hasFocus) {
//                                 //     return 'please enter valid goal title';
//                                 //   }
//                                 // }
//                                 return null;
//                               },
//                               style: TextStyle(
//                                 fontSize: SizeUtil.body(context),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RichText(
//                              textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                             textAlign: TextAlign.start,
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'Goal Value ',
//                                   style: TextStyle(
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       color: AppColors.grey),
//                                 ),
//                                 TextSpan(
//                                     text: "*",
//                                     style: TextStyle(
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         color: AppColors.red)),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 2,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 40.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5),
//                               child: TextFormField(
//                                 readOnly: widget.isWatch,
//                                 controller: goalValueController,
//                                 keyboardType:
//                                     const TextInputType.numberWithOptions(
//                                         signed: true, decimal: true),
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                   LengthLimitingTextInputFormatter(10)
//                                 ],
//                                 decoration: const InputDecoration(
//                                   filled: true,
//                                   isDense: true,
//                                   border: InputBorder.none,
//                                   hintText: 'e.g., 1000000',
//                                   hintStyle: TextStyle(color: AppColors.grey),
//                                   fillColor: TextfieldColors.background,
//                                 ),
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: (value) {
//                                   if (value!.isEmpty &&
//                                       !goalValueFocusNode.hasFocus) {
//                                     return 'goal value is required';
//                                   } else {
//                                     if (int.parse(value.toString()) == 0 &&
//                                         !goalValueFocusNode.hasFocus) {
//                                       return 'please enter valid goal value';
//                                     }
//                                   }
//                                   return null;
//                                 },
//                                 style: TextStyle(
//                                   fontSize: SizeUtil.body(context),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ]),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RichText(
//                              textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                             textAlign: TextAlign.start,
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                     text: 'Goal Target Date ',
//                                     style: TextStyle(
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         color: AppColors.grey,
//                                         fontFamily: "Helvetica")),
//                                 TextSpan(
//                                     text: "*",
//                                     style: TextStyle(
//                                         fontSize: SizeUtil.bodyLarge(context),
//                                         color: AppColors.red)),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 40),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5),
//                               child: TextFormField(
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 readOnly: true,
//                                 keyboardType: TextInputType.datetime,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                   LengthLimitingTextInputFormatter(10)
//                                 ],
//                                 decoration: InputDecoration(
//                                   suffixIcon: Padding(
//                                     padding: const EdgeInsets.only(right: 5.0),
//                                     child: GestureDetector(
//                                       onTap: () => widget.isWatch
//                                           ? () {}
//                                           : _selectgoalTargetDate(context),
//                                       child: const Icon(Icons.calendar_month,
//                                           size: 30, color: AppColors.primary),
//                                     ),
//                                   ),
//                                   suffixIconConstraints: const BoxConstraints(),
//                                   filled: true,
//                                   isDense: true,
//                                   border: InputBorder.none,
//                                   hintText: 'e.g., 01/Jun/2021',
//                                   hintStyle: const TextStyle(
//                                       color: AppColors.grey,
//                                       fontFamily: "Helvetica"),
//                                   fillColor: TextfieldColors.background,
//                                 ),
//                                 style: TextStyle(
//                                   fontSize: SizeUtil.body(context),
//                                 ),
//                                 controller: goalTargetDateController,
//                                 focusNode: goalTargetDateFocusNode,
//                                 onEditingComplete: () {
//                                   goalTargetDateFocusNode.unfocus();
//                                 },
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'goal target date is required';
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                                 onTap: () => widget.isWatch
//                                     ? () {}
//                                     : _selectgoalTargetDate(context),
//                               ),
//                             ),
//                           )
//                         ]),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         RichText(
//                            textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                           textAlign: TextAlign.start,
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Description of the item',
//                                 style: TextStyle(
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     color: AppColors.grey,
//                                     fontFamily: "Helvetica"),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 40),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: TextFormField(
//                               readOnly: widget.isWatch,
//                               controller: descriptionController,
//                               focusNode: descriptionFocusNode,
//                               onEditingComplete: () {
//                                 descriptionFocusNode.unfocus();
//                               },
//                               maxLines:
//                                   3, // Set this to null to allow multiline input
//                               decoration: const InputDecoration(
//                                 filled: true,
//                                 isDense: true,
//                                 border: InputBorder.none,
//                                 hintText: 'e.g., Necklace with Beads',
//                                 hintStyle: TextStyle(
//                                     color: AppColors.grey,
//                                     fontFamily: "Helvetica"),
//                                 fillColor: TextfieldColors.background,
//                               ),
//                               style: TextStyle(
//                                 fontSize: SizeUtil.body(context),
//                               ),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               textInputAction: TextInputAction
//                                   .newline, // Add this line to enable newline key on the keyboard
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: DefaultSizes.heightforscroll,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SmallButton(
//                 text: widget.isWatch ?"Back":"Cancel",
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 backgroundColor: AppColors.white,
//                 textColor: AppColors.primary),
//               if(!widget.isWatch)
//             SmallButton(
//                 text: "Confirm",
//                 onPressed: () {
//                   if (addGoalsFormKey.currentState!.validate()) {
//                     if(widget.isEdit){
//                          updateGoal();
//                     }else{
//                       addGoal();
//                     }
//                   }
//                 },
//                 backgroundColor: AppColors.primary,
//                 textColor: AppColors.white),
//           ],
//         ),
//       ]),
//     );
//   }

//   addGoal() async {
//     bool isSuccess = await goalsController.addNewGoals(
//         goalNameController.text.toString(),
//         double.parse(goalValueController.text.toString()),
//         goalTargetDateController.text.toString(),
//         descriptionController.text.toString(),context);

//     if (isSuccess) {
//       Navigator.maybePop(
//           context, MaterialPageRoute(builder: (context) => const Goals())).then((value) => goalsController.getGoalsList(context));
//     } else {}
//   }


//   updateGoal() async {
//     bool isSuccess = await goalsController.updateGoal(
//       widget.goalId.toString(),
//         goalNameController.text.toString(),
//         double.parse(goalValueController.text.toString()),
//         goalTargetDateController.text.toString(),
//         descriptionController.text.toString(),context);

//     if (isSuccess) {
//       Navigator.maybePop(
//           context, MaterialPageRoute(builder: (context) => const Goals())).then((value) => goalsController.getGoalsList(context));
//     } else {}
//   }
// }
