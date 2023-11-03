// import 'package:midas/constant/constant_util.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorage {
//   static late SharedPreferences preferences;

//   static Future<void> init() async {
//     preferences = await SharedPreferences.getInstance();
//   }

//   static SharedPreferences get instance {
//     return preferences;
//   }

//   static setIsBiometricEnabled(bool isBiometric) {
//     instance.setBool(ConstantUtil.bioMatric, isBiometric);
//   }

//   static bool? getIsBiometricEnabled() {
//     return instance.getBool(ConstantUtil.bioMatric);
//   }

//   static removeIsBiometricEnabled() {
//     instance.remove(ConstantUtil.bioMatric);
//   }

//   static setDeviceToken(String deviceToken) {
//     instance.setString(ConstantUtil.deviceToken, deviceToken);
//   }

//   static String? getDeviceToken() {
//     return instance.getString(ConstantUtil.deviceToken);
//   }

//   static setUserId(String userId) {
//     instance.setString(ConstantUtil.userId, userId);
//   }

//   static String? getUserId() {
//     return instance.getString(ConstantUtil.userId);
//   }

//   static setUserName(String username) {
//     instance.setString(ConstantUtil.username, username);
//   }

//   static setToken(String token) {
//     instance.setString(ConstantUtil.token, token);
//   }

//   static String? getToken() {
//     return instance.getString(ConstantUtil.token);
//   }

//   static removeToken() {
//     instance.remove(ConstantUtil.token);
//   }

//   static setUser(String user) {
//     instance.setString(ConstantUtil.user, user);
//   }

//   static String? getUser() {
//     return instance.getString(ConstantUtil.user);
//   }

//   static setBiometricAlert(bool alert) {
//     instance.setBool(ConstantUtil.biometricAlert, alert);
//   }

//   static bool? getBiometricAlert() {
//     return instance.getBool(ConstantUtil.biometricAlert);
//   }

//    static removeIsBiometricAlert() {
//     instance.remove(ConstantUtil.biometricAlert);
//   }

// }
