import 'package:flutter/material.dart';

class SuspectsPage extends StatelessWidget {
  static const routeName = '/suspects';

  final List<Map<String, String>> suspects = [
    {"name": "John Smith"},
    {"name": "Marcus Hill"},
    {"name": "Diane Porter"},
    {"name": "Carla Ruiz"},
    {"name": "Ethan Ward"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Suspects")),
      body: ListView.builder(
        itemCount: suspects.length,
        itemBuilder: (context, i) {
          final suspect = suspects[i];

          return ListTile(
            leading: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "IMG",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ),
            title: Text(suspect["name"]!),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(suspect["name"]!),
                  content: Text("Suspect profile placeholder."),
                  actions: [
                    TextButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
