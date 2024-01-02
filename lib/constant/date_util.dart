import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static String convertDateInIsoFormat(String date) {
    DateTime inputDate = DateFormat("dd/MM/yyyy").parse(date);
    String isoFormattedDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(inputDate);
    return isoFormattedDate;
  }

  Future<DateTime> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    return pickedDate!;
  }

  static Future<String> showDatePickerFromCurrentDate(
      BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      return "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
    }
    return "";
  }


  static Future<String> showDatePickerFromFifteenDaysLater(
      BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 15)),
      firstDate: DateTime.now().add(const Duration(days: 15)),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      return "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
    }
    return "";
  }


  static Future<String> showDatesAfterCurrentYear(BuildContext context) async {
     DateTime firstDateAfterCurretyear = DateTime(DateTime.now().year + 1);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDateAfterCurretyear,
      firstDate: firstDateAfterCurretyear,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      return "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
    }
    return "";
  }

  static List<String> getDaysListInCurrentMonth() {
    List<String> daysList = [];
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;
    int daysInMonth = DateTime(year, month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      daysList.add(i.toString());
    }
    return daysList;
  }

  static String formatDateInYYYYMMDD(String dateString) {
    DateTime parsedDate = DateTime.parse(
        "${dateString.substring(6, 10)}-${dateString.substring(3, 5)}-${dateString.substring(0, 2)}");
    String formattedDate =
        "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  static String checkNotificationTiming(DateTime timestamp) {
  final Duration difference = DateTime.now().difference(timestamp);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min${difference.inMinutes == 1 ? '' : ''}';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hr${difference.inHours == 1 ? '' : ''}';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} d${difference.inDays == 1 ? '' : ''}';
  } else {
    // For longer durations, return the date in a specific format
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
}
