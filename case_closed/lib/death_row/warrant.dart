import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evidence_model.dart';

class WarrantPage extends StatefulWidget {
  const WarrantPage({super.key});
  @override
  State<WarrantPage> createState() => _WarrantPageState();
}

class _WarrantPageState extends State<WarrantPage> {
  String? selectedSuspect;
  String? selectedEvidenceId;
  String? selectedMotive;

  // The Options
  final List<String> suspects = [
    "Jenna Ward",
    "Tyler Bishop", 
    "Prof. Adrian Kline",
    "Mason Duquette", 
  ];
  
  final List<String> motives = [
    "Financial Debt", 
    "Jealousy / Love Triangle", 
    "Covering up a Crime (Hazing)", 
    "Academic Fraud", 
    "Revenge"
  ];

  @override
  Widget build(BuildContext context) {
    // Get the evidence the player has actually found
    final evidenceList = Provider.of<EvidenceModel>(context).collected;

    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC), // Administrative Grey
      appBar: AppBar(
        title: const Text("Apply for Warrant"), 
        backgroundColor: const Color(0xFF2C3E50), // Police Blue
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            const Row(
              children: [
                Icon(Icons.balance, size: 40, color: Color(0xFF2C3E50)),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SUPERIOR COURT", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      Text("INDICTMENT REQUEST", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2, color: Colors.black12),
            const SizedBox(height: 20),

            // 1. SUSPECT
            _header("1. PRIMARY SUSPECT"),
            _dropdown(selectedSuspect, suspects, (v) => setState(() => selectedSuspect = v), "Identify the killer"),
            
            const SizedBox(height: 20),

            // 2. EVIDENCE
            _header("2. KEY EVIDENCE"),
            const Text("Select the item that definitively links the suspect to the murder or destroys their alibi.", style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5)),
            const SizedBox(height: 5),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12), 
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true, 
                    hint: const Text("Select Evidence from Case File"), 
                    value: selectedEvidenceId,
                    // Only show items found in the scene/suspect search!
                    items: evidenceList.map((e) => DropdownMenuItem(value: e.id, child: Text(e.title))).toList(),
                    onChanged: (v) => setState(() => selectedEvidenceId = v),
                  ),
                )
              )
            ),
            if (evidenceList.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("⚠️ Your Evidence Bag is empty. Search the Scene and Suspects.", style: TextStyle(color: Colors.red, fontSize: 12)),
              ),

            const SizedBox(height: 20),

            // 3. MOTIVE
            _header("3. ESTABLISHED MOTIVE"),
            _dropdown(selectedMotive, motives, (v) => setState(() => selectedMotive = v), "Why did they do it?"),

            const SizedBox(height: 40),

            // SUBMIT BUTTON
            SizedBox(
              width: double.infinity, height: 55, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50), 
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                onPressed: _submitWarrant, 
                child: const Text("SUBMIT TO JUDGE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Section Headers
  Widget _header(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF34495E))));
  
  // Helper for Dropdowns
  Widget _dropdown(String? val, List<String> items, Function(String?) change, String hint) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12), 
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true, 
            hint: Text(hint), 
            value: val,
            items: items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), 
            onChanged: change,
          )
        )
      )
    );
  }

  // -----------------------------------------------------------
  // CRITICAL THINKING LOGIC
  // -----------------------------------------------------------
  void _submitWarrant() {
    if (selectedSuspect == null || selectedEvidenceId == null || selectedMotive == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Application incomplete.")));
      return;
    }

    // WIN CONDITIONS
    bool suspectCorrect = selectedSuspect == "Tyler Bishop";
    bool motiveCorrect = selectedMotive == "Covering up a Crime (Hazing)";
    // The "Smoking Gun" can be the Phone (breaks alibi) OR Forensics (DNA match)
    bool evidenceCorrect = (selectedEvidenceId == "burner_phone" || selectedEvidenceId == "forensics");

    // -----------------------------------
    // SCENARIO 1: THE WIN
    // -----------------------------------
    if (suspectCorrect && motiveCorrect && evidenceCorrect) {
      _showResultDialog(
        title: "WARRANT APPROVED", 
        color: Colors.green,
        content: "JUDGE'S RULING:\n\n"
                 "The evidence is overwhelming. The forensic match on the scratches and the burner phone records place Tyler Bishop at the scene with intent.\n\n"
                 "Arrest warrant issued immediately.\n\n"
                 "CONGRATULATIONS, DETECTIVE.",
        isWin: true
      );
      return;
    }

    // -----------------------------------
    // SCENARIO 2: SPECIFIC FAILURES (HINTS)
    // -----------------------------------
    
    // RED HERRING: MASON
    if (selectedSuspect == "Mason Duquette" && selectedEvidenceId == "vials") {
      _showResultDialog(
        title: "WARRANT REJECTED",
        color: Colors.red,
        content: "JUDGE'S RULING:\n\n"
                 "Possession of sedatives is a crime, Detective, but it does not prove Mason was on that balcony. "
                 "His alibi places him in the backyard. You need proof of presence at the murder scene.",
        isWin: false
      );
      return;
    }

    // RIGHT SUSPECT, WEAK EVIDENCE (Red Cup)
    if (suspectCorrect && selectedEvidenceId == "red_cup") {
      _showResultDialog(
        title: "WARRANT REJECTED",
        color: Colors.orange,
        content: "JUDGE'S RULING:\n\n"
                 "The cup proves Tyler had access to drugs, but it is circumstantial. "
                 "It does not prove he pushed the victim. Do you have anything that physically links him to the struggle?",
        isWin: false
      );
      return;
    }

    // RIGHT SUSPECT, WRONG MOTIVE
    if (suspectCorrect && !motiveCorrect) {
      _showResultDialog(
        title: "WARRANT REJECTED",
        color: Colors.orange,
        content: "JUDGE'S RULING:\n\n"
                 "The evidence is solid, but your theory doesn't fit. "
                 "Why would he kill him for that reason? Re-examine the text messages and the victim's history.",
        isWin: false
      );
      return;
    }

    // GENERIC FAIL
    _showResultDialog(
      title: "WARRANT REJECTED",
      color: Colors.red,
      content: "JUDGE'S RULING:\n\n"
               "This application relies on speculation. The suspect's alibi holds up against this evidence.\n\n"
               "Go back to the files. Check the timestamps. Check the DNA.",
      isWin: false
    );
  }

  void _showResultDialog({required String title, required Color color, required String content, required bool isWin}) {
    showDialog(
      context: context, 
      barrierDismissible: false, 
      builder: (_) => AlertDialog(
        title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)), 
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isWin) {
                // Clear Progress and Go Home
                Provider.of<EvidenceModel>(context, listen: false).clearCurrentSession();
                Navigator.of(context).pushNamedAndRemoveUntil('/intro', (r) => false);
              }
            }, 
            child: Text(isWin ? "CASE CLOSED" : "Review Case")
          )
        ],
      )
    );
  }
}