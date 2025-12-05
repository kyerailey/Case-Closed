import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evidence_model.dart';

class EvidencePage extends StatelessWidget {
  static const routeName = '/evidence';

  @override
  Widget build(BuildContext context) {
    final evidenceModel = Provider.of<EvidenceModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Evidence")),
      body: evidenceModel.collected.isEmpty
          ? Center(child: Text("No evidence collected yet."))
          : ListView.builder(
              itemCount: evidenceModel.collected.length,
              itemBuilder: (context, i) {
                final ev = evidenceModel.collected[i];
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue.shade100,
                    child: Center(child: Text("IMG")),
                  ),
                  title: Text(ev.title),
                  subtitle: Text(ev.description),
                );
              },
            ),
    );
  }
}
