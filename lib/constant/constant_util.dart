import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

class ConstantUtil {
  static const String status = "active";
  static const String requestValidKey = "simplifinAuth123";
  static const Duration requestTimeout = Duration(seconds: 30);
  static const String requestTimeoutMesssage =
      "request timeout please try again";
  static const String internetUnavailable = "no internet connection";
  static const String bioMatric = "bioMatric";
  static const String username = "username";
  static const String userId = "userId";
  static const String deviceToken = "deviceToken";
  static const String token = "token";
  static const String user = "user";
  static const String biometricAlert = "biometricAlert";

  static const String biometricAuthMessage =
      'Unlock your screen with PIN, pattern, password, face, or biometric';
  static const String verifyBiometricAuthMessage =
      'verify your fingerprint to enable the biometric authentication';
  static const String biometricAuthEnableMessage =
      'verify your fingerprint to enable the biometric authentication';
  static const String biometricAuthNotSetMessage =
      'fingerprint not added please add your fingerprint first to continue with biometric login';
  static const String phoneNumberNotVerifieldMessage =
      'please verify your phone number to continue';
  static const String warningMessageToUploadMultipleImages =
      "when uploading a file for PAN card copy, Signature scan, Photo. File must be in jpg, jpeg, png or pdf format and size should not exceed 5 MB.";
  static const String warningMessageToUploadImage =
      "File must be in jpg, jpeg, png or pdf format and size should not exceed 5 MB.";
  static const String warningMessageToUploadVideo =
      "when uploading verification video of the investor. File must be in mp4 or webm format and size should not exceed 10 MB.";
  static const String addSuccess = "added successfully";
  static const String updateSuccess = "updated successfully";
  static const String deleteSuccess = "deleted successfully";
  static const String normalLogin = "normalLogin";
  static const String ssoLogin = "ssoLogin";

  static Future<bool> isInternetConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static String formatAmount(int number) {
    final format = NumberFormat("#,##,###", 'en_IN');
    return format.format(number);
  }

  static String formatAmountOnHeader(int number) {
    if (number >= 10000000) {
      double crore = number / 10000000.0;
      String formattedCrore = NumberFormat("#.##").format(crore);
      return '$formattedCrore Cr';
    } else if (number >= 100000) {
      double lakh = number / 100000.0;
      String formattedLakh = NumberFormat("#.##").format(lakh);
      return '$formattedLakh Lakh';
    } else if (number >= 1000) {
      double thousand = number / 1000.0;
      String formattedThousand = NumberFormat("#.##").format(thousand);
      return '$formattedThousand K';
    } else {
      final format = NumberFormat("#,##,###", 'en_IN');
      return format.format(number);
    }
  }

  static String formatDate(String originalDateStr) {
    String formattedDate = '';
    if (originalDateStr.isNotEmpty) {
      final originalFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
      final desiredFormat = DateFormat('dd MMM yyyy');

      final originalDate = originalFormat.parse(originalDateStr);
      formattedDate = desiredFormat.format(originalDate.toLocal());
    }
    return formattedDate;
  }

  static const String addressType = "address";
  static const String addressproofBackType="addressProofBack";
  static const String bankAccountType="bankAccountProof";
  static const String pancardType="pancardDoc";
  static const String signDocType="signDoc";
  static const String photoDocType="photoDoc";
  static const String ipvVedioType="ipvVedio";



}
