import 'package:asignment/widgets/SignInForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: const Color.fromARGB(255, 234, 243, 247),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: Get.height * .4,
              child: Image.asset("assets/images/Login.png"),
            ),
            const FormPage()
          ]),
        ),
      ),
    );
  }
}
