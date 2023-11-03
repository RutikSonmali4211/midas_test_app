import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:midas/constant/application_urls.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:http/http.dart'as http;




class AuthorizationInterceptor implements InterceptorContract {
  
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {

    try {
      // Fetching token from your locacl data
      var token =LocalStorage.getToken();
      
      // Clear previous header and update it with updated token
      request.headers.clear();

      request.headers['authorization'] =  token!;
      request.headers['content-type'] = 'application/json';
    } catch (e) {
      print(e);
    }

    return request;
  }
  
  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async{
   return response;
  }
  
  @override
  Future<bool> shouldInterceptRequest() {
    throw UnimplementedError();
  }
  
  @override
  Future<bool> shouldInterceptResponse() {
    throw UnimplementedError();
  }

   // Currently we do not have any need to intercept response
  // @override
  // Future<ResponseData> interceptResponse({required ResponseData data}) async {
  //   return data;
  // }
}


//2 Retry Policy
//This is where request retry
class ExpiredTokenRetryPolicy extends RetryPolicy {
  
  //Number of retry
  @override
  int maxRetryAttempts = 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    //This is where we need to update our token on 401 response
    if (response.statusCode == 401) {
      //Refresh your token here. Make refresh token method where you get new token from
      //API and set it to your local data
      // await HelperFunction.refreshToekn();  //Find bellow the code of this function
      return true;
    }
    return false;
  }
}

//3 API Class where we have request methods
class ApiBaseHelper {
  //Setting up your client with interceptors
  static final client = InterceptedClient.build(
    interceptors: [AuthorizationInterceptor()],
  );

  static Future<dynamic> httpGetRequest(String endPoint,
      {String base = ApplicationUrls.baseUrl}) async {
    var token =
        LocalStorage.getToken();
    http.Response response;
    try {
       //Request with interceptor client
      response = await client.get(Uri.parse('$base$endPoint'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
    } on SocketException {
      throw "internet is not available";
    } on FormatException {
      throw 'something went wrong';
    }

    return _returnResponse(response);
  }
  
  
  static dynamic _returnResponse(http.Response response) {
  String responseJson = response.body;
  final jsonResponse = jsonDecode(responseJson);
  switch (response.statusCode) {
    case 200:
      return jsonResponse;
    case 400:
      throw 
          jsonResponse['message'] ?? "";
    case 401:
      throw  jsonResponse['message'] ?? "";
    case 403:
      throw  jsonResponse['message'] ?? "";
    case 404:
      throw  jsonResponse['message'] ?? "";
    case 500:
    default:
      throw  jsonResponse['message'] ?? "";
  }
}
}

//4
// This piecce of code has nothing to do with interceptor
// This is for those who need to know how to refresh the token using REST API
// static Future<void> refreshToekn() async {
//     print('refresh token hit');
//     try {
//       RefreshTokenResponse response =
//           await RefreshTokenService.refreshTokenRequest();
//       print(response.token);
//       //Here we are updating our token on local storage
//       AppLocalData().setStringPrefValue(
//           key: AppConstants.userTokenKey, value: response.token!);
//     } catch (e) {
//       print('catch on refresh');
//       showSnackBar(e.toString());
//     }
//   }
// }




















// class NetworkHandler {
//   final Dio dio = Dio();
//   String? accessToken = LocalStorage.instance.getString('token');

//   final _storage = LocalStorage.instance;
  

//   NetworkHandler() {
//     dio.interceptors
//         .add(InterceptorsWrapper(onRequest: (options, handler) async {
//       if (!options.path.contains('http')) {
//         options.path = 'http://10.0.2.2:3000/${options.path}';
//       }
//       options.headers['Authorization'] = accessToken;
//       return handler.next(options);
//     }, onError: (DioError error, handler) async {
//       if ((error.response?.statusCode == 419)) {
//         if (_storage.containsKey('token')) {
//           if (await refreshToken()) {
//             return handler.resolve(await _retry(error.requestOptions));
//           }
//         }
//       }
//       return handler.next(error);
//     }));
//   }

//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return dio.request<dynamic>(requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: options);
//   }

//   Future<bool> refreshToken() async {
//     final refreshToken = _storage.getString('token');
//     final response = await dio
//         .post('auth/refreshToken', data: {'token': refreshToken});

//     if (response.statusCode == 200) {
//      var jsonResponse= jsonDecode(response.data);
//       accessToken = jsonResponse['refreshToken'];
//       return true;
//     } else {
//       // refresh token is wrong
//       accessToken = null;
//       _storage.remove('token');
//       return false;
//     }
//   }
// }