import 'dart:convert';
import 'package:http/http.dart' as http;

class AccountService {
  String accountUrl = "http://10.0.2.2:3000/auth/accounts";

  getAccountData() async {
    // String? token = LocalStorage.instance.getString("token");
    try {
      var response = await http.get(
        Uri.parse(accountUrl),
        headers: {
          "Content-Type": "application/json",
          "authorization":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQ0YWRlODVhYWMyYzBjYjI0NTE0MjciLCJlbWFpbCI6InJ1dGlrQGdtYWlsLmNvbSIsImlhdCI6MTY5MTY2NDk2MywiZXhwIjoxNjkxNjY4NTYzfQ.MEpa-Cm6SDK8mSPhgMOdog9Jgz6Gf5--HJRIyKFMsdM"
        },
      );
      // print(response);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        return jsonResponse;
      }
    } catch (e) {
      return "";
    }
  }
}
