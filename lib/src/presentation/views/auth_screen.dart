import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english/src/presentation/views/categories_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

enum AuthMode {
  logIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = 'auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.logIn;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? imagePath;

  void _authSwitcher() {
    setState(() {
      if (_authMode == AuthMode.signUp) {
        _authMode = AuthMode.logIn;
      } else {
        _authMode = AuthMode.signUp;
      }
    });
  }

  void _onSaved() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_authMode != AuthMode.logIn && imagePath == null) {
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please pick an image'),
        duration: Duration(seconds: 1),
      ),);
      return;
    }
    formKey.currentState!.save();
    try {
      if (_authMode == AuthMode.signUp) {
        final userCreadintials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);

        final storageRef = FirebaseStorage.instance.ref().child('user_images').child('${userCreadintials.user!.uid}.jpg');
        await storageRef.putFile(imagePath!);
        String imageUrl=await storageRef.getDownloadURL();
        print(imageUrl);

        await FirebaseFirestore.instance.collection('users').doc('${userCreadintials.user!.uid}').set({
          "imageUrl":imageUrl,
          "username":_username.text,
          "email":_email.text,
        });
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
      }
      context.goNamed(CategoriesScreen.routeName);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? "Authentication failed"),
          duration: const Duration(seconds: 1),
        ),
        
      );
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
                      _authMode == AuthMode.logIn ? "SignUp" : "LogIn",
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
                key: UniqueKey(),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email!';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Email is invalid';
                  } else {
                    return null;
                  }
                },
                controller: _email,
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
                  key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Please enter valid username!';
                    } else {
                      return null;
                    }
                  },
                  controller: _username,
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
                controller: _password,
                key: UniqueKey(),
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
                  key: UniqueKey(),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid password!';
                    } else if (value != _password.text) {
                      return 'Password is wrong';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorMaxLines: 1,
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
                  controller: _passwordConfirm,
                  onSaved: (newValue) => _onSaved(),
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
                  _authMode == AuthMode.logIn ? 'LogIn' : "SignUp",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
