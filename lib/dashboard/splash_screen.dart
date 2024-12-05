import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/auth/provider/splash_provider.dart';
import 'package:snapkart_admin/auth/view/login_screen.dart';
import 'package:snapkart_admin/dashboard/dashboard_screen.dart';
import 'package:snapkart_admin/windowSports/adaptiveUI/home_adaptive_uI.dart';
import 'package:snapkart_admin/windowSports/responsive_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    decideScreen();
  }

  Future<void> decideScreen() async {
    Future.delayed(const Duration(seconds: 5), () {});

    SplashProvider provider =
        Provider.of<SplashProvider>(context, listen: false);
    await provider.checkLogged();
    if (provider.isLogged) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ResponsiveUi(mobile: DashBoardScreen(), window: HomeAdaptiveUi())),
        );
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash_logo2.jpg',
          height: 150,
          width: 150,
          color: Colors.black,
        ),
      ),
    );
  }
}
