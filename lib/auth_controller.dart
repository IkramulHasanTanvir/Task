
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanvir/models/User_data.dart';

class AuthController {
  static const String _tokenKey = 'token-key';
  static const String _userDataKey = 'user-data';

  static String? accessToken;
  static User? userData;


  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    accessToken = token;
  }

  static Future<void> saveUserData(User userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        _userDataKey, jsonEncode(userModel.toJson()));
    userData = userModel;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    accessToken = token;
    return token;
  }

  static Future<User?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedData = sharedPreferences.getString(_userDataKey);
    if (userEncodedData == null) {
      return null;
    }
    User userModel = User.fromJson(jsonDecode(userEncodedData));
    userData = userModel;
    return userModel;
  }

  static bool isLoggedIn() {
    return accessToken != null;
  }

  static Future<void> clearAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_userDataKey);
    accessToken = null;
  }
}
