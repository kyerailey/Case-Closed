import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evidence_model.dart';
import '../main.dart'; // For AppColors
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

// THE CLUES
final List<Hotspot> hotspots = [
  Hotspot(id: "red_cup", title: "Red Solo Cup", description: "Smells of alcohol. Lab results indicate traces of 'Benzodiazepine' mixed with the beer.", left: 0.70, top: 0.80),
  Hotspot(id: "necklace", title: "Silver Chain", description: "Broken at the clasp. Engraved with 'TB' on the back. Found in dust layer.", left: 0.30, top: 0.65),
  Hotspot(id: "burner_phone", title: "Prepaid Cellphone", description: "Screen cracked. Last text at 12:10 AM: 'Get up here now.' No contact name saved.", left: 0.85, top: 0.50),
  Hotspot(id: "receipt", title: "Crumpled Receipt", description: "Found in trash. Purchase of 'TracFone Prepaid'. Paid via Credit Card ending in #8842.", left: 0.20, top: 0.85),
  Hotspot(id: "hoodie", title: "Ripped Hoodie", description: "Found behind planter. Dark fabric with blood spatter (Type O+).", left: 0.10, top: 0.40),
];

class DeathRowScene extends StatelessWidget {
  const DeathRowScene({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CASE FILE: #001: DEATH ON THE ROW"),
          backgroundColor: const Color(0xFF0F202E), 
          
          // ****************************************************
          // NEW BUTTON LOCATION (TOP RIGHT)
          // ****************************************************
          actions: [
            // 1. LEAVE BUTTON (Blue/Grey)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface, // Blue/Grey
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                icon: const Icon(Icons.exit_to_app, size: 18),
                label: const Text("LEAVE"),
                onPressed: () => _showLeaveDialog(context),
              ),
            ),

            // 2. SAVE BUTTON (Red/Accent)
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 12, top: 8, bottom: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent, // Red
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                icon: const Icon(Icons.save, size: 18),
                label: const Text("SAVE"),
                onPressed: () => _showSaveDialog(context),
              ),
            ),
          ],

          // TABS UNDER THE BUTTONS
          bottom: const TabBar(
            indicatorColor: AppColors.accent, 
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Scene"),
              Tab(text: "Suspects"),
              Tab(text: "Evidence"),
            ],
          ),
        ),
        
        body: const TabBarView(
          children: [
            InteractiveSceneTab(),
            SuspectsTab(),
            EvidenceTab(),
          ],
        ),
        
        // Removed FloatingActionButton because we moved them to the top!
      ),
    );
  }

  // ----------------------------------------------------------
  // LOGIC: SAVE
  // ----------------------------------------------------------
  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _buildCustomDialog(
        context: ctx,
        title: "Save Progress?",
        content: "This will overwrite any previous save file.",
        yesText: "Save",
        noText: "Cancel",
        // SAVE BUTTON COLOR (Red)
        yesColor: AppColors.accent,
        onYes: () async {
          // 1. Write to Disk
          await Provider.of<EvidenceModel>(context, listen: false).saveProgress();
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Game Saved Successfully."), backgroundColor: Colors.green)
          );
        },
      ),
    );
  }

  // ----------------------------------------------------------
  // LOGIC: LEAVE
  // ----------------------------------------------------------
  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _buildCustomDialog(
        context: ctx,
        title: "Leave Case?",
        content: "Any unsaved evidence will be lost forever.",
        yesText: "Leave",
        noText: "Stay",
        // LEAVE BUTTON COLOR (Blue)
        yesColor: AppColors.surface, 
        onYes: () {
          // 1. Clear RAM (Session Data)
          // This ensures that if they didn't save, the evidence is GONE.
          Provider.of<EvidenceModel>(context, listen: false).clearCurrentSession();

          // 2. Go Home
          Navigator.pop(ctx); // Close Dialog
          Navigator.pop(context); // Exit Page
        },
      ),
    );
  }

  // Helper for the popups
  Widget _buildCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String yesText,
    required String noText,
    required Color yesColor,
    required VoidCallback onYes,
  }) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
      content: Text(content, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400, foregroundColor: Colors.white),
          onPressed: () => Navigator.pop(context),
          child: Text(noText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: yesColor, foregroundColor: Colors.white),
          onPressed: onYes,
          child: Text(yesText),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------
// INTERACTIVE SCENE (Unchanged logic, just keeping it here for completeness)
// -----------------------------------------------------------------------
class InteractiveSceneTab extends StatelessWidget {
  const InteractiveSceneTab({super.key});

  @override
  Widget build(BuildContext context) {
    final evidenceModel = Provider.of<EvidenceModel>(context, listen: false);

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/crime_scene.png'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...hotspots.map((h) {
            return Positioned(
              left: h.left * constraints.maxWidth, 
              top: h.top * constraints.maxHeight,
              child: GestureDetector(
                onTap: () => _showDialog(context, h, evidenceModel),
                child: Container(
                  width: 60, height: 60,
                  //color: Colors.transparent, 
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3), // Faint red fill
                    border: Border.all(color: Colors.red, width: 2), // Red border
                  ),
                ),
              ),
            );
          }),
        ],
      );
    });
  }

  void _showDialog(BuildContext context, Hotspot h, EvidenceModel model) {
    bool isCollected = model.collected.any((e) => e.id == h.id);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(h.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(h.description),
            if (isCollected) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.green)),
                child: const Row(children: [Icon(Icons.check_circle, size: 20, color: Colors.green), SizedBox(width: 10), Expanded(child: Text("Evidence already collected", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)))]),
              ),
            ]
          ],
        ),
        actions: [
          TextButton(
            child: Text(isCollected ? "Close" : "Collect Evidence"),
            onPressed: () {
              if (!isCollected) {
                model.addEvidence(Evidence(id: h.id, title: h.title, description: h.description));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${h.title} added to case file."), backgroundColor: Colors.green, duration: const Duration(seconds: 2)));
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}