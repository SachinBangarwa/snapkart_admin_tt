import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/auth/model/user_model.dart';
import 'package:snapkart_admin/auth/provider/auth_provider.dart';
import 'package:snapkart_admin/auth/view/sing_up_screen.dart';
import 'package:snapkart_admin/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: "email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "password", border: OutlineInputBorder()),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Consumer<AuthProvider>(
                builder: (context,provider,child){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: (){
                            loginButton(context);
                          },
                          child:
                          provider.isLogged?const SpinKitThreeBounce(color: Colors.red,size: 15,): const Text("login"),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SingUpScreen()));
                      }, child:const Text('Sing_Up'))
                    ],
                  );
                },

              ),
            ),

          ],
        ),
      ),
    );
  }

  Future loginButton(BuildContext context) async {
    UserModel userModel =
    UserModel(nameController.text, passwordController.text);
    AuthProvider authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    await authProvider.login(userModel);
    if (authProvider.isAuthenticated) {
      if(context.mounted){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const DashBoardScreen()));
      }}
    nameController.clear();
    passwordController.clear();
  }
}
