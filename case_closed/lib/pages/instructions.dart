import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Instructions")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Tap a case to begin the investigation.\n\n"
          "Use hotspots to collect evidence.\n"
          "Use comparison tools to evaluate suspects.\n"
          "You can save/load progress anytime.",
        ),
      ),
    );
  }
}
