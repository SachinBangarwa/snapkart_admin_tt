import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snapkart_admin/auth/model/user_model.dart';
import 'package:snapkart_admin/core/api_endpoint.dart';

class AuthService {
  Future<String> login(UserModel user) async {
    final response = await http.post(
      Uri.parse(ApiEndpoint.loginUrl),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode==200){
      final map= jsonDecode(response.body);
      final token=map['token'];
      return token;
    }else{
      throw 'not achieve the token';
    }
  }
  Future<bool> singUp(UserModel user) async {
    String url = ApiEndpoint.singUpUrl;
    String strUser = jsonEncode(user.toJson());
    final response = await http.post(Uri.parse(url),
        body: strUser, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
