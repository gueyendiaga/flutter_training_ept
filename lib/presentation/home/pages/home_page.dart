import 'package:flutter/material.dart';

class HomePage extends StatefulWidget { // StatefulWidget widget avec etat mutable
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Home Page'),
        leading: Icon(Icons.arrow_back),
      ),
    );
  }
}