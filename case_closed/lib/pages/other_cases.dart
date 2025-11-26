import 'package:flutter/material.dart';

class CommonCasesScreen extends StatelessWidget {
  const CommonCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Other Cases")),
      body: const Center(
        child: Text("Common Case List Coming Soon..."),
      ),
    );
  }
}