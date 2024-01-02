// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/model/notifications/notifications_model.dart';
import 'package:midas/service/notifications/notification_service.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';

class NotificationController extends GetxController {

  NotificationService notificationService = NotificationService();

  var isLoadingNotificationList = false.obs;
  var isLoadingMoreNotificationList = false.obs;
  var noMoreDataLoadNotificationList = false.obs;

  // int page = 1;
  int pageSize = 10;

  RxList notificationsList = <NotificationsModel>[].obs;


   Future<bool> getNotifications(int page, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      if (page == 1) {
        isLoadingNotificationList.value = true;
      }
      var response = await notificationService.getNotifications(page, pageSize, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (page == 1) {
          notificationsList.clear();
        }
        List data = jsonResponse['result'];
        if (data.length < pageSize) {
          noMoreDataLoadNotificationList.value = true;
        }
        for (var element in jsonResponse['result']) {
          NotificationsModel notification = NotificationsModel.fromJson(element);
          notificationsList.add(notification);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(NotificationController, "ERROR",
            "error in getting all notifications data ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      isLoadingNotificationList.value = false;
    }
    return false;
  }


  deleteNotification(String notificationId, BuildContext context) async {
    try {
      isLoadingNotificationList.value = true;
      var response = await notificationService.deleteNotification(notificationId, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert(jsonResponse['message']);
        getNotifications(1,context);
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(NotificationController, "ERROR",
            "error in delete notification ${jsonResponse['message']}");
      } else {
        showErrorAlert(jsonResponse['message']);
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
    } finally {
      isLoadingNotificationList.value = false;
    }
  }





}