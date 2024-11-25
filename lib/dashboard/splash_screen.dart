import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/auth/provider/splash_provider.dart';
import 'package:snapkart_admin/auth/view/login_screen.dart';
import 'package:snapkart_admin/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  //  decideScreen();
    super.initState();
  }

  Future decideScreen() async {
    SplashProvider provider =
        Provider.of<SplashProvider>(context, listen: false);
    await provider.checkLogged();
    if (provider.isLogged) {
      if(mounted){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashBoardScreen()));
    }}
   else{
      if(mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Center(
      child: FlutterSplashScreen.gif(
        useImmersiveMode: true,
        gifPath: 'assets/home_artist.png',
        gifHeight:260 ,
        gifWidth: 474,
        backgroundColor: Colors.black,
        duration: Duration(seconds: 5),
        nextScreen:  DashBoardScreen(),

      ),
    ),

    );
  }
}
