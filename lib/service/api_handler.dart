// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'package:midas/constant/application_urls.dart';
// import 'package:midas/constant/constant_util.dart';
// import 'package:midas/exception/custom_exception.dart';
// import 'package:midas/screen/sign_in/sign_in.dart';
// import 'package:midas/storage/local_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ApiHandler {
//   static Future<http.Response> _handleRequest(
//       http.Request request, BuildContext context) async {
//     try {
//       if (!await ConstantUtil.isInternetConnected()) {
//         throw CustomException(ConstantUtil.internetUnavailable);
//       }
//       final accessToken = LocalStorage.getToken();
//       if (accessToken!.isNotEmpty) {
//         request.headers['Content-Type'] = "application/json";
//         request.headers['Authorization'] = accessToken;
//       }

//       final client = http.Client();
//       final responseStream = await client
//           .send(request)
//           .timeout(ConstantUtil.requestTimeout, onTimeout: () {
//         throw CustomException(ConstantUtil.requestTimeoutMesssage);
//       });
//       final response = await http.Response.fromStream(responseStream);
//       var jsonResponse = jsonDecode(response.body);
//       if (response.statusCode == 419) {
//         final refreshedToken = await refreshToken(context);
//         if (refreshedToken!.isNotEmpty) {
//           final newRequest = http.Request(request.method, request.url)
//             ..headers.addAll(request.headers)
//             ..body = request.body;
//           newRequest.headers['Authorization'] = refreshedToken;
//           final newResponseStream = await client.send(newRequest);
//           final newresponse = await http.Response.fromStream(newResponseStream);
//           return newresponse;
//         }
//       } else if (response.statusCode == 401) {
//         LocalStorage.removeToken();
//         Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const SignInScreen()),
//             (Route route) => false);
//         throw CustomException(jsonResponse['message'] ?? "unauthorized access");
//       }
//       client.close();
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   static Future<String?> refreshToken(BuildContext context) async {
//     String? accessToken = LocalStorage.getToken();
//     var response = await http.post(
//       Uri.parse(ApplicationUrls.refreshTokenUrl),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": accessToken!
//       },
//     );
//     var jsonResponse = jsonDecode(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final refreshToken = jsonResponse['result']['refreshToken'];
//       print("refresh token called");
//       LocalStorage.setToken(refreshToken);
//       return refreshToken;
//     } else {
//       LocalStorage.removeToken();
//       Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const SignInScreen()),
//           (Route route) => false);
//       throw CustomException(jsonResponse['message']);
//     }
//   }

//   static Future<http.Response> get(String path,
//       Map<String, dynamic> requestBody, BuildContext context) async {
//     final request = http.Request('GET', Uri.parse(path));
//     request.body = json.encode(requestBody);
//     return await _handleRequest(request, context);
//   }

//   static Future<http.Response> post(String path,
//       Map<String, dynamic> requestBody, BuildContext context) async {
//     final request = http.Request('POST', Uri.parse(path));
//     request.body = json.encode(requestBody);
//     return await _handleRequest(request, context);
//   }

//   static Future<http.Response> put(String path,
//       Map<String, dynamic> requestBody, BuildContext context) async {
//     final request = http.Request('PUT', Uri.parse(path));
//     request.body = json.encode(requestBody);
//     return await _handleRequest(request, context);
//   }

//   static Future<http.Response> delete(String path,
//       Map<String, dynamic> requestBody, BuildContext context) async {
//     final request = http.Request('DELETE', Uri.parse(path));
//     request.body = json.encode(requestBody);
//     return await _handleRequest(request, context);
//   }
// }
