import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});
  static const routeName = 'result-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Result",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
