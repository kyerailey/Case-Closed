import 'package:flutter/material.dart';

class DeathRowScreen extends StatelessWidget {
  const DeathRowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Death on the Row")),
      body: const Center(
        child: Text("Death Row Case Coming Soon..."),
      ),
    );
  }
}
