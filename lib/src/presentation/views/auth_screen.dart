import 'package:flutter/material.dart';

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

  void _onSaved(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Form(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Enter an email",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Enter your username",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Enter your password",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Confirm your password",
                ),
              ),
              ElevatedButton(
                onPressed: _onSaved,
                child: Text('LogIn'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  maximumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
