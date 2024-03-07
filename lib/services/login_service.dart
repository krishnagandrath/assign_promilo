import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

const String apiUrl = 'https://apiv2stg.promilo.com/user/oauth/token';

class LoginService {
  Future<bool> checkLogin(String email, String password) async {
    final client = http.Client();
    final shaPass = sha256.convert(utf8.encode(password)).toString();
    final headers = {'Authorization': 'Basic UHJvbWlsbzpxNCE1NkBaeSN4MiRHQg=='};
    final payload = {
      "username": "test45@yopmail.com",
      "password": shaPass,
      "grant_type": "password",
    };
    try {
      final response =
          await client.post(Uri.parse(apiUrl), body: payload, headers: headers);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
    return false;
  }
}
