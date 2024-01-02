import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';
class NotificationService {


   Future<http.Response> getNotifications(int page,int pageSize,BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.getNotificationsUrl}/$userId?page=$page&pageSize=$pageSize",
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteNotification(String notificationId, BuildContext context) async {
    try {
      var response = await ApiHandler.delete(
          "${ApplicationUrls.getNotificationsUrl}/$notificationId", {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }



}