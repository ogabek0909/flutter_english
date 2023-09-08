import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum AuthMode {
  logIn,
  signIn,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = 'auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.signIn;
  final formKey = GlobalKey<FormState>();

  File? imagePath;

  void _authSwitcher() {
    setState(() {
      if (_authMode == AuthMode.signIn) {
        _authMode = AuthMode.logIn;
      } else {
        _authMode = AuthMode.signIn;
      }
    });
  }

  void _onSaved() {
    if (!formKey.currentState!.validate()) {
      return;
    }
  }

  void _pickAnImage() async {
    final imagePicker = ImagePicker();

    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (xFile == null) {
      return;
    }

    setState(() {
      imagePath = File(xFile.path);
    });

    print(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _authSwitcher,
                    child: Text(
                      _authMode == AuthMode.signIn ? "SignIn" : "LogIn",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Center(
                child: _authMode != AuthMode.logIn
                    ? Stack(
                        fit: StackFit.passthrough,
                        children: [
                          CircleAvatar(
                            radius: 63,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.blueGrey,
                              backgroundImage: imagePath != null
                                  ? FileImage(imagePath!)
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: IconButton(
                              onPressed: _pickAnImage,
                              icon: const Icon(
                                Icons.add_photo_alternate_rounded,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Image.asset(
                        'assets/images/dash.png',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
              if (_authMode == AuthMode.logIn) const SizedBox(height: 30),
              const SizedBox(height: 50),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter valid email!';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter an email",
                  filled: true,
                  fillColor: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              if (_authMode != AuthMode.logIn)
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Please enter valid username!';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter your username",
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                ),
              if (_authMode != AuthMode.logIn) const SizedBox(height: 10),
              if (_authMode == AuthMode.logIn) const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Please enter valid password!';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter your password",
                  filled: true,
                  fillColor: Colors.white70,
                ),
              ),
              if (_authMode != AuthMode.logIn) const SizedBox(height: 10),
              // if (_authMode == AuthMode.logIn) const SizedBox(height: 100),
              if (_authMode != AuthMode.logIn)
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Please enter valid password!';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Confirm your password",
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: _onSaved,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'LogIn',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
