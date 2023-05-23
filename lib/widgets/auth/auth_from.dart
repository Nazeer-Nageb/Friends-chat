import 'dart:io';

import 'package:chat/pickers/user_image_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Authform extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String phone,
    String username,
    File image,
    bool islogin,
    BuildContext ctx,
  ) submitfn;
  bool isloading;
  Authform({required this.submitfn, required this.isloading});

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formkey = GlobalKey<FormState>();
  bool _islogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  File? _userimageFile;
  String your_number_phone = '';
  void _pickedImage(File pickedImage) {
    _userimageFile = pickedImage;
  }

  void _submit() {
    final bool? isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (!_islogin && _userimageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid!) {
      _formkey.currentState?.save();
      widget.submitfn(
          _email.trim(),
          _password.trim(),
          your_number_phone.trim(),
          _username.trim(),
          _userimageFile == null ? File('') : _userimageFile!,
          _islogin,
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'images/vector.png',
            fit: BoxFit.fill,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Center(
                  child: Text(
                'FREINDS CHAT ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    color: Colors.redAccent),
              )),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            if (!_islogin)
                              UserImagePicker(imagepickfn: _pickedImage),
                            Padding(padding: EdgeInsets.all(5)),
                            TextFormField(
                              autocorrect: false,
                              enableSuggestions: false,
                              textCapitalization: TextCapitalization.none,
                              key: ValueKey('email'),
                              validator: (val) {
                                if (val!.isEmpty || !val.contains('@')) {
                                  return 'please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (val) => _email = val!,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                                border: OutlineInputBorder(),
                                hintText: 'your_email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            if (!_islogin)
                              TextFormField(
                                autocorrect: true,
                                enableSuggestions: false,
                                textCapitalization: TextCapitalization.words,
                                key: ValueKey('username'),
                                validator: (val) {
                                  if (val!.isEmpty || val.length < 4) {
                                    return 'please enter at least 4 characters';
                                  }
                                  return null;
                                },
                                onSaved: (val) => _username = val!,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  border: OutlineInputBorder(),
                                  hintText: 'your_name',
                                  prefixIcon: Icon(Icons.verified_user),
                                ),
                              ),
                            Padding(padding: EdgeInsets.all(5)),
                            if (!_islogin)
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'please enter your phone number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  prefix: Text('+963   '),
                                  border: OutlineInputBorder(),
                                  labelText: 'phone',
                                  hintText: 'your_number_phone',
                                  prefixIcon: Icon(Icons.phone),
                                ),
                                onSaved: (val) {
                                  your_number_phone = val!;
                                },
                              ),
                            Padding(padding: EdgeInsets.all(5)),
                            TextFormField(
                              key: ValueKey('password'),
                              validator: (val) {
                                if (val!.isEmpty || val.length < 7) {
                                  return 'please enter at least 7 characters';
                                }
                                return null;
                              },
                              onSaved: (val) => _password = val!,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                hintText: 'your_password',
                                  prefixIcon: Icon(Icons.password_rounded),
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (widget.isloading) CircularProgressIndicator(),
                            if (!widget.isloading)
                              ElevatedButton(
                                  onPressed: _submit,
                                  child: Text(_islogin ? 'Login' : 'Sign Up')),
                            if (!widget.isloading)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _islogin = !_islogin;
                                  });
                                },
                                // ignore: sort_child_properties_last
                                child: Text(_islogin
                                    ? 'Create new account'
                                    : 'I already have an account'),
                                style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor))),
                              )
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
