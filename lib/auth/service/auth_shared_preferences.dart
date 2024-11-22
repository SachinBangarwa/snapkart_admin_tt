import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPreferences{
static String tokenKey='token';
 static Future saveToken(String token)async{
   SharedPreferences prefer=await SharedPreferences.getInstance();
   prefer.setString(tokenKey, token);
  }
static Future<String?> getToken()async{
  SharedPreferences prefer=await SharedPreferences.getInstance();
 return prefer.getString(tokenKey);
}
static Future removeToken()async{
   SharedPreferences preferences=await SharedPreferences.getInstance();
   preferences.remove(tokenKey);
}

}