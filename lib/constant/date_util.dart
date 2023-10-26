import 'package:intl/intl.dart';

class DateUtil {
  static String convertDateInIsoFormat(String date) {
    DateTime inputDate = DateFormat("dd/MM/yyyy").parse(date);
    String isoFormattedDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(inputDate);
    return isoFormattedDate;
  }
}
