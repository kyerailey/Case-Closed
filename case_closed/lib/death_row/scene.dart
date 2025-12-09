import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evidence_model.dart';
import '../main.dart'; // For AppColors
import 'suspects.dart'; 
import 'evidence.dart'; 
// Import Background so we can review it
import 'background.dart';

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
  // 1. Red Cup (Bottom Right)
  Hotspot(
    id: "red_cup", 
    title: "Red Solo Cup", 
    description: "Smells of alcohol. Lab results indicate traces of 'Benzodiazepine' mixed with the beer.", 
    left: 0.72, 
    top: 0.72
  ),

  // 2. Necklace (Bottom Left - The chain on the floor)
  Hotspot(
    id: "necklace", 
    title: "Silver Chain", 
    description: "Broken at the clasp. Engraved with 'TB' on the back. Found in dust layer.", 
    left: 0.12, 
    top: 0.82
  ),

  // 3. Burner Phone (Middle Left - The white phone)
  Hotspot(
    id: "burner_phone", 
    title: "Prepaid Cellphone", 
    description: "Screen cracked. Last text at 12:10 AM: 'Get up here now.' No contact name saved.", 
    left: 0.15, 
    top: 0.58
  ),

  // 4. Receipt (Hidden near the cup/trash)
  Hotspot(
    id: "receipt", 
    title: "Crumpled Receipt", 
    description: "Found in trash. Purchase of 'TracFone Prepaid'. Paid via Credit Card ending in #8842.", 
    left: 0.85, 
    top: 0.75
  ),

  // 5. Hoodie (Center - The green sweatshirt)
  Hotspot(
    id: "hoodie", 
    title: "Ripped Hoodie", 
    description: "Found behind planter. Dark fabric with blood spatter (Type O+).", 
    left: 0.42, 
    top: 0.42
  ),
];

class DeathRowScene extends StatelessWidget {
  const DeathRowScene({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CASE FILE #001: DEATH ON THE ROW"),
          backgroundColor: const Color(0xFF0F202E), 
          
          // ****************************************************
          // 1. REVIEW CASE BUTTON (Top Left)
          // ****************************************************
          leading: IconButton(
            icon: const Icon(Icons.description), // File Document Icon
            tooltip: "Review Case File",
            onPressed: () {
              // Open the Background page again
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const DeathRowBackground())
              );
            },
          ),
          
          // ****************************************************
          // 2. ABORT & SAVE BUTTONS (Top Right)
          // ****************************************************
          actions: [
            // ABORT BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface, 
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                icon: const Icon(Icons.delete_forever, size: 18), 
                label: const Text("ABORT"),
                onPressed: () => _showLeaveDialog(context),
              ),
            ),

            // SAVE & EXIT BUTTON
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 12, top: 8, bottom: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent, 
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                icon: const Icon(Icons.save, size: 18),
                label: const Text("SAVE & EXIT"), 
                onPressed: () => _showSaveDialog(context),
              ),
            ),
          ],

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
      ),
    );
  }

  // ----------------------------------------------------------
  // LOGIC: SAVE & EXIT
  // ----------------------------------------------------------
  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _buildCustomDialog(
        context: ctx,
        title: "Save & Exit?",
        content: "Your progress will be saved and you will return to the main menu.",
        yesText: "Save & Exit",
        noText: "Cancel",
        yesColor: AppColors.accent,
        onYes: () async {
          // 1. Write to Disk
          await Provider.of<EvidenceModel>(context, listen: false).saveProgress();
          
          // 2. Close Dialog & Exit
          Navigator.pop(ctx);
          Navigator.of(context).popUntil((route) => route.isFirst); 
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Progress Saved."), backgroundColor: Colors.green)
          );
        },
      ),
    );
  }

  // ----------------------------------------------------------
  // LOGIC: ABORT (DELETE SAVE)
  // ----------------------------------------------------------
  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _buildCustomDialog(
        context: ctx,
        title: "Abort Investigation?",
        content: "This will DELETE your save file and restart the investigation. Are you sure?",
        yesText: "Abort (Delete Save)",
        noText: "Stay",
        yesColor: AppColors.surface, 
        onYes: () async {
          // 1. DELETE FROM DISK & RAM
          await Provider.of<EvidenceModel>(context, listen: false).deleteSaveFile();

          // 2. Close Dialog & Exit
          Navigator.pop(ctx); 
          Navigator.of(context).popUntil((route) => route.isFirst); 
        },
      ),
    );
  }

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
// INTERACTIVE SCENE TAB
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
                  color: Colors.red.withOpacity(0.5), // *** DEBUG CHANGE: Set to RED ***
                  //color: Colors.transparent, // Invisible
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