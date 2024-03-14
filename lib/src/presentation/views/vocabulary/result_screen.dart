import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});
  static const routeName = 'result-screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/result.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.06),
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text(
            "Your Result",
          ),
          leading: IconButton(
            onPressed: () {
              context.pop();
              context.pop();
            },
            icon: const Icon(Icons.chevron_left_sharp, size: 30),
          ),
        ),
        body: Center(
          
        )
      ),
    );
  }
}
