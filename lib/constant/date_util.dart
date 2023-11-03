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

}
