// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:midas/constant/constant_util.dart';
// import 'package:midas/constant/date_util.dart';
// import 'package:midas/exception/custom_exception.dart';
// import 'package:midas/logs/Loggers.dart';
// import 'package:midas/model/goals/goals_model.dart';
// import 'package:midas/service/goals/goals_service.dart';
// import 'package:midas/widgets/alert_message/snackbar.dart';
// import 'package:midas/widgets/loader.dart';

// class GoalsController extends GetxController {
//   final GolasService golasService = GolasService();
//   int currentPage = 1;
//   int pageSize = 5;
//   bool canLoadMore = true;
//   var isLoading = false.obs;
//   final goalsList = <GoalsModel>[].obs;

//   Future<bool> addNewGoals(String goalName, double goalValue,
//       String goalTargetDate, String description, BuildContext context) async {
//     try {
//       Loader.showLoading();
//       if (!await ConstantUtil.isInternetConnected()) {
//         throw CustomException(ConstantUtil.internetUnavailable);
//       }
//       String convertedGoalTargetDate =
//           DateUtil.convertDateInIsoFormat(goalTargetDate);
//       var response = await golasService.addNewGoal(
//           goalName, goalValue, convertedGoalTargetDate, description, context);
//       var jsonResponse = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         showSuccessAlert(jsonResponse['message'] ?? "goal added successfully");
//         // getGoalsList(context, page: 1);
//         return true;
//       } else if (response.statusCode >= 500) {
//         await Loggers.printLog(GoalsController, "ERROR",
//             "error in add goals ${jsonResponse['message']}");
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

//   getGoalsList(BuildContext context, {int page = 1}) async {
//     try {
//       if (!await ConstantUtil.isInternetConnected()) {
//         throw CustomException(ConstantUtil.internetUnavailable);
//       }
//       if (page == 1) {
//         currentPage = page;
//         canLoadMore = true;
//       }
//       if (!canLoadMore) {
//         return;
//       }
//       // isLoading.value = true;
//       var response =
//           await golasService.getGoalsList(currentPage, pageSize, context);
//       var jsonResponse = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         if (page == 1) {
//           goalsList.clear();
//         }
//         currentPage++;
//         for (var element in jsonResponse['result']) {
//           GoalsModel goals = GoalsModel.fromJson(element);
//           goalsList.add(goals);
//         }
//         update();
//         // canLoadMore = jsonResponse['result'].length >= pageSize;
//         canLoadMore=true;
//         return canLoadMore;
//       } else if (response.statusCode >= 500) {
//         await Loggers.printLog(GoalsController, "ERROR",
//             "error in get goals list ${jsonResponse['message']}");
//         return true;
//       } else {
//         showErrorAlert(jsonResponse['message']);
//         return true;
//       }
//     } catch (e) {
//       if (e is CustomException) {
//         showErrorAlert(e.toString());
//       }
//     } finally {
//       isLoading.value = false;
//     }
//     // try {
//     //   if (!await ConstantUtil.isInternetConnected()) {
//     //     throw CustomException(ConstantUtil.internetUnavailable);
//     //   }
//     //   isLoading.value = true;
//     //   var response = await golasService.getGoalsList(context);
//     //   var jsonResponse = jsonDecode(response.body);
//     //   if (response.statusCode == 200) {
//     //     goalsList.clear();
//     //     for (var element in jsonResponse['result']) {
//     //       GoalsModel goals = GoalsModel.fromJson(element);
//     //       goalsList.add(goals);
//     //     }
//     //     update();
//     //   } else if (response.statusCode >= 500) {
//     //     await Loggers.printLog(GoalsController, "ERROR",
//     //         "error in get goals list ${jsonResponse['message']}");
//     //   } else {
//     //     showErrorAlert(jsonResponse['message']);
//     //   }
//     // } catch (e) {
//     //   if (e is CustomException) {
//     //     showErrorAlert(e.toString());
//     //   }
//     // } finally {
//     //   isLoading.value = false;
//     // }
//   }

//   deleteGoal(String goalId, BuildContext context) async {
//     try {
//       isLoading.value = true;
//       var response = await golasService.deleteGoal(goalId, context);
//       var jsonResponse = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         showSuccessAlert(jsonResponse['message']);
//         getGoalsList(context, page: 1);
//         update();
//       } else if (response.statusCode >= 500) {
//         await Loggers.printLog(GoalsController, "ERROR",
//             "error in delete goal ${jsonResponse['message']}");
//       } else {
//         showErrorAlert(jsonResponse['message']);
//       }
//     } catch (e) {
//       if (e is CustomException) {
//         showErrorAlert(e.toString());
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<bool> updateGoal(String goalId, String goalName, double goalValue,
//       String goalTargetDate, String description, BuildContext context) async {
//     try {
//       Loader.showLoading();
//       if (!await ConstantUtil.isInternetConnected()) {
//         throw CustomException(ConstantUtil.internetUnavailable);
//       }
//       String convertedGoalTargetDate =
//           DateUtil.convertDateInIsoFormat(goalTargetDate);
//       var response = await golasService.updateGoal(goalId, goalName, goalValue,
//           convertedGoalTargetDate, description, context);
//       var jsonResponse = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         showSuccessAlert(jsonResponse['message']);
//         update();
//         // getGoalsList(context, page: 1);
//         return true;
//       } else if (response.statusCode >= 500) {
//         await Loggers.printLog(GoalsController, "ERROR",
//             "error in update goal ${jsonResponse['message']}");
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
