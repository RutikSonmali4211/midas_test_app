class ApplicationUrls {
  // static const String baseUrl = 'http://10.0.2.2:3000/';
  static const String baseUrl = 'http://devmidasadmin.ergobite.com:3000/';
  static const String signUpUrl = '${baseUrl}auth/signup';
  static const String signInUrl = '${baseUrl}auth/signin';
  static const String signOutUrl = '${baseUrl}auth/signout';
  static const String refreshTokenUrl = '${baseUrl}auth/refreshToken';
  static const String setBiometricLoginEnabledOrDisabledUrl =
      '${baseUrl}users/biomatric';
  static const String checkBiometricEnabledUrl =
      '${baseUrl}auth/checkbiometricenable';
  static const String addDeviceTokenForBiometricUrl =
      '${baseUrl}users/addnewdevicetoken';
  static const String usersUrl =
      '${baseUrl}users';
  static const String signInWithBiometricUrl = '${baseUrl}auth/signinbiometric';
  static const String dropDownUrl = "${baseUrl}dropdownData";
  static const String investmentUrl = "${baseUrl}investment";
  static const String goalsUrl = "${baseUrl}goals";
  static const String userUrl = "${baseUrl}users";
  static const String getGoalsListByUserIdUrl = "${baseUrl}goals";
  static const String goldTypesUrl = "${baseUrl}goldType";
  static const String getTodaysGoldRatesUrl = "${baseUrl}goldType/today";
  static const String contactUsUrl = "${baseUrl}contactUs";
  static const String sendOtpUrl = "${baseUrl}sms/sendotp";
  static const String verifyOtpUrl = "${baseUrl}sms/verifyotp";
  static const String netWorthUrl = "${baseUrl}netWorth/checkNetWorth";
}
