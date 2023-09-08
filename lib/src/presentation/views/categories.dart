import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  static const routeName = 'categories-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
