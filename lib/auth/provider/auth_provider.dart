import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapkart_admin/auth/model/user_model.dart';
import 'package:snapkart_admin/auth/service/auth_service.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/core/service/storage_helper.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this.authService);

  AuthService authService;
  bool isAuthenticated = false;
  bool isLogged=false;
  String? errorMessage;

  Future login(UserModel user) async {
    try {
      isLogged=true;
      notifyListeners();
       isAuthenticated = false;
      String token = await authService.login(user);
    await  StorageHelper.saveToken(token);
      isLogged=false;
      if (token.isNotEmpty) {
        isAuthenticated = true;
        notifyListeners();
        AppUtil.showToast('login success');
      }
    } catch (error) {
      isLogged = false;
      notifyListeners();
      if (error is SocketException) {
        AppUtil.showToast('Internet not available');
      } else {
        AppUtil.showToast(error.toString());
      }
    }
  }
  Future<void> singUp(UserModel user) async {
    try {
       isAuthenticated = false;
      bool success = await authService.singUp(user);
      isAuthenticated = success;
      if (success) {
        AppUtil.showToast('sing Up success');
      }
      notifyListeners();
    } catch (error) {
      isAuthenticated = false;
      notifyListeners();
    }
  }
  Future loggedOut()async{
    try{
      errorMessage=null;
    await StorageHelper.removeToken();
  }catch(error){
     errorMessage=error.toString();
    }
    notifyListeners();
  }
}
