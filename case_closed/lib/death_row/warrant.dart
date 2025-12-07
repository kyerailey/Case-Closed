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

  final List<String> suspects = ["Tyler Bishop", "Mason Duquette", "Jenna Ward", "Prof. Adrian Kline"];
  final List<String> motives = ["Financial Debt", "Jealousy / Love Triangle", "Covering up a Crime (Hazing)", "Academic Fraud", "Revenge"];

  @override
  Widget build(BuildContext context) {
    final evidenceList = Provider.of<EvidenceModel>(context).collected;

    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      appBar: AppBar(title: const Text("Apply for Warrant"), backgroundColor: const Color(0xFF2C3E50)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("INDICTMENT REQUEST FORM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            const Divider(thickness: 2), const SizedBox(height: 20),

            _header("1. TARGET SUSPECT"),
            _dropdown(selectedSuspect, suspects, (v) => setState(() => selectedSuspect = v)),
            
            const SizedBox(height: 20),
            _header("2. KEY EVIDENCE"),
            const Text("Select the item that proves presence or guilt.", style: TextStyle(fontSize: 12, color: Colors.grey)),
            Card(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: DropdownButtonHideUnderline(child: DropdownButton<String>(
              isExpanded: true, hint: const Text("Select Evidence"), value: selectedEvidenceId,
              items: evidenceList.map((e) => DropdownMenuItem(value: e.id, child: Text(e.title))).toList(),
              onChanged: (v) => setState(() => selectedEvidenceId = v),
            )))),

            const SizedBox(height: 20),
            _header("3. ESTABLISHED MOTIVE"),
            _dropdown(selectedMotive, motives, (v) => setState(() => selectedMotive = v)),

            const SizedBox(height: 40),
            SizedBox(width: double.infinity, height: 55, child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C3E50), foregroundColor: Colors.white),
              onPressed: _submitWarrant, child: const Text("SUBMIT TO JUDGE"),
            )),
          ],
        ),
      ),
    );
  }

  Widget _header(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7F8C8D))));
  
  Widget _dropdown(String? val, List<String> items, Function(String?) change) {
    return Card(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: DropdownButtonHideUnderline(child: DropdownButton<String>(
      isExpanded: true, hint: const Text("Select..."), value: val,
      items: items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: change,
    ))));
  }

  void _submitWarrant() {
    if (selectedSuspect == null || selectedEvidenceId == null || selectedMotive == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Form incomplete.")));
      return;
    }
    // WIN LOGIC: Tyler + (Phone OR Forensics) + Hazing
    bool suspectOK = selectedSuspect == "Tyler Bishop";
    bool motiveOK = selectedMotive == "Covering up a Crime (Hazing)";
    bool evidenceOK = (selectedEvidenceId == "burner_phone" || selectedEvidenceId == "forensics");

    if (suspectOK && motiveOK && evidenceOK) {
      _result("WARRANT APPROVED", "Judge: 'The evidence is compelling. Arrest warrant issued.'\n\nCASE CLOSED.", true);
    } else {
      _result("WARRANT REJECTED", "Judge: 'This application is insufficient. Review your evidence and try again.'", false);
    }
  }

  void _result(String t, String c, bool win) {
    showDialog(context: context, barrierDismissible: false, builder: (_) => AlertDialog(
      title: Text(t, style: TextStyle(color: win ? Colors.green : Colors.red)), content: Text(c),
      actions: [TextButton(onPressed: () {
        Navigator.pop(context);
        if (win) Navigator.of(context).pushNamedAndRemoveUntil('/intro', (r) => false);
      }, child: const Text("Close"))],
    ));
  }
}