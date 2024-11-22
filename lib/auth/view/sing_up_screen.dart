import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/auth/model/user_model.dart';
import 'package:snapkart_admin/auth/provider/auth_provider.dart';
import 'package:snapkart_admin/auth/view/login_screen.dart';
import 'package:snapkart_admin/core/app_util.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sing _Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: "username", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "password", border: OutlineInputBorder()),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: InkWell(
                  onTap: loginButton,
                  child: const Text("Sing_UP"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void loginButton() async {
    UserModel userModel =
    UserModel(nameController.text, passwordController.text);
    AuthProvider authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    await authProvider.singUp(userModel);
    if (authProvider.isAuthenticated&&mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }else{
      AppUtil.showToast("not match");
    }
  }
}

