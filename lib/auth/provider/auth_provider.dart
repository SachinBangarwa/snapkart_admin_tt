import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snapkart_admin/auth/model/user_model.dart';
import 'package:snapkart_admin/auth/service/auth_service.dart';
import 'package:snapkart_admin/auth/service/auth_shared_preferences.dart';
import 'package:snapkart_admin/core/app_util.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this.authService);

  AuthService authService;
  bool isAuthenticated = false;
  bool isLoginAuthenticated = false;
  bool isLogged=false;
  String? errorMessage;

  Future login(UserModel user) async {
    try {
      isLogged=true;
      notifyListeners();
      String token = await authService.login(user);
    await  AuthSharedPreferences.saveToken(token);
    print(token);
      isLogged=false;
      if (token.isNotEmpty) {
        isLoginAuthenticated = true;
        notifyListeners();
        AppUtil.showToast('login success');
      }
    } catch (e) {
      isLogged=false;
      AppUtil.showToast(e.toString());
    }
    notifyListeners();
  }
  Future<void> singUp(UserModel user) async {
    try {
      bool success = await authService.singUp(user);
      isAuthenticated = success;
      if (success) {
        AppUtil.showToast('sing Up success');
      }
      notifyListeners();
    } catch (e) {
      isAuthenticated = false;
      notifyListeners();
    }
  }
  Future loggedOut()async{
    try{
      errorMessage=null;
    await AuthSharedPreferences.removeToken();
  }catch(e){
     errorMessage=e.toString();
    }
    notifyListeners();
  }
}
