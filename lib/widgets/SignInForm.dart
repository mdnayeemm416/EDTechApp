import 'package:flutter/material.dart';
import 'package:asignment/Function/FireBaseAuth.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  var password = "";
  var email = "";
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  if (!isLogin)
                    buildTextFormField("User Name", Icons.person, (value) {
                      return value!.length <= 3
                          ? "Please insert a proper user name"
                          : null;
                    }, (newValue) {
                      username = newValue!;
                    }),
                  const SizedBox(height: 10),
                  buildTextFormField("Email", Icons.email_rounded, (value) {
                    return !value!.contains("@")
                        ? "Please insert a proper email"
                        : null;
                  }, (newValue) {
                    email = newValue!;
                  }),
                  const SizedBox(height: 10),
                  buildTextFormField("Password", Icons.password, (value) {
                    return value!.length <= 4
                        ? "Please insert a proper password"
                        : null;
                  }, (newValue) {
                    password = newValue!;
                  }),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              isLogin
                  ? login(email, password, context)
                  : signUp(email, password, username, context);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            backgroundColor: Colors.blue,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(
            isLogin ? "Sign In" : "Sign Up",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin
                ? "Don't have an account? Sign Up!"
                : "Already have an account? Sign In!",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildTextFormField(
    String hintText,
    IconData icon,
    FormFieldValidator<String> validator,
    FormFieldSetter<String> onSaved,
  ) {
    return TextFormField(
      key: ValueKey(hintText),
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hintText,
        icon: Icon(icon),
        iconColor: Colors.blue,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
