import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evidence_model.dart';

class Hotspot {
  final String id;
  final String title;
  final String description;
  final double left;
  final double top;
  final double width;
  final double height;

  Hotspot({
    required this.id,
    required this.title,
    required this.description,
    required this.left,
    required this.top,
    this.width = 0.08,
    this.height = 0.08,
  });
}

final List<Hotspot> hotspots = [
  Hotspot(
      id: "bottle",
      title: "Broken Bottle",
      description: "A shattered bottle lying near the couch.",
      left: 0.62,
      top: 0.62),
  Hotspot(
      id: "blood",
      title: "Blood Stain",
      description: "Blood stain found on the couch.",
      left: 0.45,
      top: 0.48),
];

class ScenePage extends StatelessWidget {
  static const routeName = '/scene';

  @override
  Widget build(BuildContext context) {
    final evidenceModel = Provider.of<EvidenceModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Crime Scene")),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            // *************** PLACEHOLDER CRIME SCENE ***************
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  "Crime Scene Placeholder\n(Insert Image Later)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            ),

            // **************** HOTSPOTS ****************
            ...hotspots.map((h) {
              return Positioned(
                left: h.left * constraints.maxWidth,
                top: h.top * constraints.maxHeight,
                width: h.width * constraints.maxWidth,
                height: h.height * constraints.maxHeight,
                child: GestureDetector(
                  onTap: () {
                    final ev = Evidence(
                      id: h.id,
                      title: h.title,
                      description: h.description,
                    );
                    _showHotspotDialog(context, ev, evidenceModel);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.transparent),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      }),
    );
  }
}

void _showHotspotDialog(BuildContext context, Evidence evidence, EvidenceModel model) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(evidence.title),
      content: Text(evidence.description),
      actions: [
        TextButton(
          child: Text("Add to Evidence"),
          onPressed: () {
            model.addEvidence(evidence);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
