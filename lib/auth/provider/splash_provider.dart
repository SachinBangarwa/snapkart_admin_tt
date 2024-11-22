import 'package:flutter/cupertino.dart';
import 'package:snapkart_admin/auth/service/auth_shared_preferences.dart';

class SplashProvider extends ChangeNotifier{
    bool? isLogged;
  Future checkLogged()async{
    String? token=await AuthSharedPreferences.getToken();
    if(token!=null){
      isLogged=true;
    }else{
      isLogged=false;
    }
    notifyListeners();

  }


}