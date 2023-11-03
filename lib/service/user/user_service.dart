// import 'dart:convert';
// import 'package:midas/constant/application_urls.dart';
// import 'package:midas/constant/constant_util.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:midas/exception/custom_exception.dart';
// import 'package:midas/service/api_handler.dart';

// class UserService {
//   String userStatus = "active";

//   // this service is used to register the new user in the application
//   Future<http.Response> registerUser(
//       String name,
//       String email,
//       String mobileNumber,
//       String username,
//       String password,
//       bool isSso,
//       String pan,
//       String aadhaar,
//       String startDate,
//       String endDate,
//       List<Map<String, dynamic>> data,
//       List<Map<String, dynamic>> financialData) async {
//     try {
//       var response = await http
//           .post(Uri.parse(ApplicationUrls.signUpUrl),
//               headers: {
//                 "Content-Type": "application/json",
//                 "isvalidrequest": ConstantUtil.requestValidKey
//               },
//               body: json.encode({
//                 "name": name,
//                 "email": email,
//                 "mobileNumber": mobileNumber,
//                 "password": password,
//                 "isSso": isSso,
//                 "pan": pan,
//                 "startDate": startDate,
//                 "endDate": endDate,
//                 "data": [],
//                 "financialData": [],
//                 "topSellingCategoryAccount": [],
//                 "topSellingCategoryCard": [],
//                 "status": userStatus,
//               }))
//           .timeout(ConstantUtil.requestTimeout, onTimeout: () {
//         throw ConstantUtil.requestTimeoutMesssage;
//       });
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // this service is used to login the existing user
//   Future<http.Response> loginUser(
//       String email, String password, String type) async {
//     try {
//       var response = await http
//           .post(Uri.parse(ApplicationUrls.signInUrl),
//               headers: {
//                 "Content-Type": "application/json",
//                 "isvalidrequest": ConstantUtil.requestValidKey
//               },
//               body: json.encode({
//                 "email": email,
//                 "password": password,
//                 "type": type,
//               }))
//           .timeout(ConstantUtil.requestTimeout, onTimeout: () {
//         throw CustomException(ConstantUtil.requestTimeoutMesssage);
//       });
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<http.Response> logoutUser(BuildContext context) async {
//     try {
//       final response =
//           await ApiHandler.post(ApplicationUrls.signOutUrl, {}, context);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // this service is used to login the existing user
//   Future<http.Response> loginWithBiometric(
//       String deviceToken, String userId) async {
//     try {
//       var response = await http
//           .post(Uri.parse(ApplicationUrls.signInWithBiometricUrl),
//               headers: {
//                 "Content-Type": "application/json",
//                 "isvalidrequest": ConstantUtil.requestValidKey
//               },
//               body: json.encode({
//                 "deviceToken": deviceToken,
//                 "userId": userId,
//               }))
//           .timeout(ConstantUtil.requestTimeout, onTimeout: () {
//         throw CustomException(ConstantUtil.requestTimeoutMesssage);
//       });
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // this service is used to add device token for biometric login
//   Future<http.Response> addDeviceTokenForBiometricLogin(
//       String deviceToken, String userId) async {
//     try {
//       var response = await http
//           .post(Uri.parse(ApplicationUrls.addDeviceTokenForBiometricUrl),
//               headers: {
//                 "Content-Type": "application/json",
//                 "isvalidrequest": ConstantUtil.requestValidKey
//               },
//               body: json.encode({
//                 "deviceToken": deviceToken,
//                 "userId": userId,
//               }))
//           .timeout(ConstantUtil.requestTimeout, onTimeout: () {
//         throw CustomException(ConstantUtil.requestTimeoutMesssage);
//       });
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // this service is used for set biometric login enabled or disabled
//   Future<http.Response> setBiometricLoginEnabledOrDisabled(String userId,
//       bool flag, String deviceToken, BuildContext context) async {
//     Map<String, dynamic> requestBody = {
//       "userId": userId,
//       "flag": flag,
//       "deviceToken": deviceToken,
//     };
//     try {
//       var response = await ApiHandler.post(
//           ApplicationUrls.setBiometricLoginEnabledOrDisabledUrl,
//           requestBody,
//           context);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<http.Response> updatePin(
//       String userId, String pin, BuildContext context) async {
//     try {
//       Map<String, dynamic> requestBody = {
//         "password": pin,
//       };
//       var response = await ApiHandler.put(
//           "${ApplicationUrls.userUrl}/$userId", requestBody, context);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<http.Response> updateInvestmentProfile(
//       String userId,
//       List<Map<String, dynamic>> investmentProfileData,
//       BuildContext context) async {
//     try {
//       Map<String, dynamic> requestBody = {
//         "investmentProfile": investmentProfileData,
//       };
//       var response = await ApiHandler.put(
//           "${ApplicationUrls.userUrl}/$userId", requestBody, context);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<http.Response> checkDeviceTokenAddedOrNot(
//       String userId, String deviceToken) async {
//     try {
//       var response =
//           await http.post(Uri.parse(ApplicationUrls.checkBiometricEnabledUrl),
//               headers: {
//                 "Content-Type": "application/json",
//                 "isvalidrequest": ConstantUtil.requestValidKey
//               },
//               body: json.encode({
//                 "userId": userId,
//                 "deviceToken": deviceToken,
//               }));
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<http.Response> getUserDetailsById(
//       String userId, BuildContext context) async {
//     try {
//       var response = await ApiHandler.get(
//           "${ApplicationUrls.usersUrl}/$userId", {}, context);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
