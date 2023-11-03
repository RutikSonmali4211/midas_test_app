//   import 'dart:convert';

// import 'package:http/http.dart'as http;

//  Future<dynamic> responseHandler({
//   required http.Response response}) {
//   var jsonResponse= jsonDecode(response.body);
//   switch (response.statusCode) {
//     case 200:
//       return jsonResponse;
//     case 400:
//       throw 
//           jsonResponse['message'] ?? "";
//     case 401:
//       throw  jsonResponse['message'] ?? "";
//     case 403:
//       throw  jsonResponse['message'] ?? "";
//     case 404:
//       throw  jsonResponse['message'] ?? "";
//     case 500:
//     default:
//       throw  jsonResponse['message'] ?? "";
//   }
// }





















// //   void responseHandler({
// //   required http.Response response,
// //   required BuildContext context,
// //   required VoidCallback onSuccess,
// // }) {
// //   switch (response.statusCode) {
// //     case 200:
// //       onSuccess();
// //       break;
// //     case 400:
// //       showErrorAlert(jsonDecode(response.body)['message']);
// //       break;
// //     case 401:
// //       showErrorAlert(jsonDecode(response.body)['message']);
// //       break;
// //     case 500:
// //       showErrorAlert(jsonDecode(response.body)['message']);
// //       break;
// //     default:
// //       showErrorAlert(response.body);
// //   }
// // }