import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/app_routes.dart';
import '../controller/login_controller.dart';
import 'package:flutter_application_1/custom_widgets/input_fields.dart';


class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(title: Container(
          height: 50,
          child: Image.asset('assets/images/neighborly_logo.jpg'),
        ),
        centerTitle: true,),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/images/neighborly_logo.jpg')
                  ),
            MyTextField(
                controller: controller.emailController,
                hintText: 'Email',
                obscureText: false,),
            MyTextField(
                controller: controller.passwordController,
                hintText: 'Password',
                obscureText: true,),
            Container(
              height: 80,
              padding: const EdgeInsets.all(20),
            child: ElevatedButton(style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),onPressed: controller.login, 
            child: const Text('Login')),),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.reg);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}