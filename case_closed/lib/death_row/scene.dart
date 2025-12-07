import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evidence_model.dart';
import '../main.dart'; 
import 'suspects.dart'; 
import 'evidence.dart'; 

class Hotspot {
  final String id;
  final String title;
  final String description;
  final double left;
  final double top;
  Hotspot({required this.id, required this.title, required this.description, required this.left, required this.top});
}

// HARD MODE CLUES
final List<Hotspot> hotspots = [
  Hotspot(id: "red_cup", title: "Red Solo Cup", description: "Smells of alcohol. Lab results indicate traces of 'Benzodiazepine' mixed with the beer.", left: 0.70, top: 0.80),
  Hotspot(id: "necklace", title: "Silver Chain", description: "Broken at the clasp. Engraved with 'TB' on the back. Found in dust layer.", left: 0.30, top: 0.65),
  Hotspot(id: "burner_phone", title: "Prepaid Cellphone", description: "Screen cracked. Last text at 12:10 AM: 'Get up here now.' No contact name saved.", left: 0.85, top: 0.50),
  Hotspot(id: "receipt", title: "Crumpled Receipt", description: "Found in trash. Purchase of 'TracFone Prepaid'. Paid via Credit Card ending in #8842.", left: 0.20, top: 0.85),
  Hotspot(id: "hoodie", title: "Ripped Hoodie", description: "Found behind planter. Dark fabric with blood spatter (Type O+).", left: 0.10, top: 0.40),
  Hotspot(id: "forensics", title: "Forensic Report", description: "Analysis of scratches on Tyler's arm: Contains traces of victim's skin cells/DNA.", left: 0.50, top: 0.10),
];

class DeathRowScene extends StatelessWidget {
  const DeathRowScene({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Case #001"),
          backgroundColor: const Color(0xFF0F202E), 
          bottom: const TabBar(
            indicatorColor: AppColors.accent, 
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [Tab(text: "Scene"), Tab(text: "Suspects"), Tab(text: "Evidence")],
          ),
        ),
        body: const TabBarView(
          children: [InteractiveSceneTab(), SuspectsTab(), EvidenceTab()],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: "leave_btn",
                onPressed: () => _showLeaveDialog(context),
                backgroundColor: Colors.redAccent.shade100,
                label: const Text("Leave"),
                icon: const Icon(Icons.exit_to_app),
              ),
              const SizedBox(width: 15),
              FloatingActionButton.extended(
                heroTag: "save_btn",
                onPressed: () => _showSaveDialog(context),
                backgroundColor: AppColors.surface,
                label: const Text("Save"),
                icon: const Icon(Icons.save),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _buildCustomDialog(
        context: ctx,
        title: "Save Progress?",
        content: "Save your current findings?",
        yesText: "Yes", noText: "No",
        onYes: () async {
          await Provider.of<EvidenceModel>(context, listen: false).saveProgress();
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Game Saved."), backgroundColor: Colors.green));
        },
      ),
    );
  }

  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _buildCustomDialog(
        context: ctx,
        title: "Leave Case?",
        content: "Unsaved progress will be lost.",
        yesText: "Leave", noText: "Stay", isDestructive: true,
        onYes: () { Navigator.pop(ctx); Navigator.pop(context); },
      ),
    );
  }

  Widget _buildCustomDialog({required BuildContext context, required String title, required String content, required String yesText, required String noText, required VoidCallback onYes, bool isDestructive = false}) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
      content: Text(content, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey), onPressed: () => Navigator.pop(context), child: Text(noText)),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: isDestructive ? Colors.red : AppColors.buttonColor), onPressed: onYes, child: Text(yesText)),
      ],
    );
  }
}

class InteractiveSceneTab extends StatelessWidget {
  const InteractiveSceneTab({super.key});
  @override
  Widget build(BuildContext context) {
    final evidenceModel = Provider.of<EvidenceModel>(context, listen: false);
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Container(
            width: constraints.maxWidth, height: constraints.maxHeight,
            color: const Color(0xFF597D9D),
            child: const Center(child: Text("Scene Image Placeholder", style: TextStyle(color: Colors.white30))),
          ),
          ...hotspots.map((h) {
            return Positioned(
              left: h.left * constraints.maxWidth, top: h.top * constraints.maxHeight,
              child: GestureDetector(
                onTap: () => _showDialog(context, h, evidenceModel),
                child: Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(color: Colors.red.withOpacity(0.3), border: Border.all(color: Colors.red)),
                ),
              ),
            );
          }),
        ],
      );
    });
  }

  void _showDialog(BuildContext context, Hotspot h, EvidenceModel model) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(h.title), content: Text(h.description),
        actions: [TextButton(child: const Text("Collect"), onPressed: () {
              model.addEvidence(Evidence(id: h.id, title: h.title, description: h.description));
              Navigator.pop(context);
            })],
      ),
    );
  }
}