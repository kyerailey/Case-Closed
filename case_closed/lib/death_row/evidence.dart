import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evidence_model.dart';
import '../main.dart';

class EvidenceTab extends StatelessWidget {
  const EvidenceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EvidenceModel>(
      builder: (context, model, child) {
        return Container(
          color: AppColors.buttonColor, // Steel Blue
          child: model.collected.isEmpty
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.search, size: 60, color: Colors.white54), Text("No Evidence Found", style: TextStyle(color: Colors.white70))]))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: model.collected.length,
                  itemBuilder: (context, i) {
                    final ev = model.collected[i];
                    return Card(
                      color: AppColors.surface,
                      child: ListTile(
                        leading: const Icon(Icons.check_circle, color: Colors.greenAccent),
                        title: Text(ev.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(ev.description, style: const TextStyle(color: Colors.white70)),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}