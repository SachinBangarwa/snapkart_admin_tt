import 'package:flutter/cupertino.dart';
import 'package:snapkart_admin/core/service/storage_helper.dart';

class SplashProvider extends ChangeNotifier{
    bool isLogged=false;
  Future<bool> checkLogged()async{
    String? token=await StorageHelper.getToken();
    if(token!=null){
      isLogged=true;
    }else{
      isLogged=false;
    }
    return isLogged;

  }


}