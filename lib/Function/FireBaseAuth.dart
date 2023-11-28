import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> signUp(
    String email, var password, String username, BuildContext context) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    String UID = credential.user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .set({"username": username, "email": email});
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Account Already exists")));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Weak password")));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Already exists")));
    }
  } catch (e) {
    print(e);
  }
}

Future<void> login(String email, var password, BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Incorrect User or Password"),
        behavior: SnackBarBehavior.floating,
        
      ));
    } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {}
  }
}

signout() async {
  await FirebaseAuth.instance.signOut();
}