import 'dart:io';

import 'package:chat/widgets/auth/auth_from.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isloading = false;
  void _submitAuthForm(String email, String password, String phone,
      String username, File image, bool islogin, BuildContext cxt) async {
    UserCredential? authresult;
    try {
      setState(() {
        _isloading = true;
      });
      if (islogin) {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authresult.user!.uid + 'jpg');
        await ref.putFile(image);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(authresult.user!.uid)
            .set({
          'username': username,
          'password': password,
          'image_url': url,
          'email': email,
          'phone': phone
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = 'error Ocurred';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(cxt).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isloading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Authform(submitfn: _submitAuthForm, isloading: _isloading),
    );
  }
}
