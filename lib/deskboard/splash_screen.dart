import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/auth/provider/splash_provider.dart';
import 'package:snapkart_admin/auth/view/login_screen.dart';
import 'package:snapkart_admin/deskboard/deskboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    decideScreen();
    super.initState();
  }

  Future decideScreen() async {
    SplashProvider provider =
        Provider.of<SplashProvider>(context, listen: false);
    await provider.checkLogged();
    if (provider.isLogged != null && mounted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DeskBoardScreen()));
    }
   else{
      if(mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Start')));
  }
}
