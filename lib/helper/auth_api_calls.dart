import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> apiLoginUser(String email, String password) {
  return http.post(
    Uri.parse('http://localhost:8000/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password
    }),
  );
}

Future<http.Response> apiRegisterUser(String username, String email, String password, String confirmpw) {
  return http.post(
    Uri.parse('http://localhost:8000/api/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'email': email,
      'password': password,
      'confirm_password': confirmpw,
    }),
  );
}