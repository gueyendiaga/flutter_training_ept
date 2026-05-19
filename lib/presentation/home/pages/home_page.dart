import 'package:flutter/material.dart';
import 'package:flutter_training/presentation/home/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(),
    );
  }
}

// StatelessWidget = UI fixe (sans memmoire)

// StatefulWidget = UI dynamique (avec memmoire)


