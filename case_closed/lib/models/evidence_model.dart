import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Evidence {
  final String id;
  final String title;
  final String description;

  Evidence({
    required this.id,
    required this.title,
    required this.description,
  });
}

class EvidenceModel extends ChangeNotifier {
  // INTERNAL STATE
  final List<Evidence> _collected = [];
  bool _hasSaveFile = false; 

  // GETTERS
  List<Evidence> get collected => _collected;
  bool get hasSaveFile => _hasSaveFile;

  // ----------------------------------------------------------------
  // 1. ADD EVIDENCE (Memory Only)
  // ----------------------------------------------------------------
  void addEvidence(Evidence evidence) {
    // Prevent duplicates
    if (!_collected.any((e) => e.id == evidence.id)) {
      _collected.add(evidence);
      notifyListeners();
    }
  }

  // ----------------------------------------------------------------
  // 2. SAVE PROGRESS (Write to Disk)
  // ----------------------------------------------------------------
  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert the list of objects into a list of Strings (IDs)
    final List<String> evidenceIds = _collected.map((e) => e.id).toList();
    
    await prefs.setStringList('death_row_evidence', evidenceIds);
    await prefs.setBool('death_row_saved', true); 
    
    _hasSaveFile = true;
    notifyListeners();
  }

  // ----------------------------------------------------------------
  // 3. LOAD PROGRESS (Read from Disk)
  // ----------------------------------------------------------------
  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    _hasSaveFile = prefs.getBool('death_row_saved') ?? false;

    if (_hasSaveFile) {
      final List<String>? savedIds = prefs.getStringList('death_row_evidence');
      
      if (savedIds != null) {
        _collected.clear();
        
        // RECONSTRUCT EVIDENCE BASED ON ID
        // (This ensures the descriptions match your "Hard Mode" updates)
        for (String id in savedIds) {
          if (id == 'red_cup') {
            _collected.add(Evidence(id: 'red_cup', title: 'Red Solo Cup', description: 'Smells of alcohol. Lab results indicate traces of \'Benzodiazepine\' mixed with the beer.'));
          } else if (id == 'necklace') {
             _collected.add(Evidence(id: 'necklace', title: 'Silver Chain', description: 'Broken at the clasp. Engraved with \'TB\' on the back. Found in dust layer.'));
          } else if (id == 'burner_phone') {
             _collected.add(Evidence(id: 'burner_phone', title: 'Prepaid Cellphone', description: 'Screen cracked. Last text at 12:10 AM: \'Get up here now.\''));
          } else if (id == 'receipt') {
             _collected.add(Evidence(id: 'receipt', title: 'Crumpled Receipt', description: 'Found in trash. Purchase of \'TracFone Prepaid\'. Paid via Credit Card ending in #8842.'));
          } else if (id == 'hoodie') {
             _collected.add(Evidence(id: 'hoodie', title: 'Ripped Hoodie', description: 'Found behind planter. Dark fabric with blood spatter (Type O+).'));
          } 
          // HIDDEN ITEMS FOUND VIA SEARCH
          else if (id == 'forensics') {
             _collected.add(Evidence(id: 'forensics', title: 'Forensic Report', description: 'Tyler\'s arm has fresh scratches containing the victim\'s DNA.'));
          } else if (id == 'vials') {
             _collected.add(Evidence(id: 'vials', title: 'Empty Vials', description: 'Found in Mason\'s desk. Label torn off, but traces of sedative remain.'));
          }
        }
        notifyListeners();
      }
    }
  }

  // ----------------------------------------------------------------
  // 4. CLEAR SESSION (For "Leave" Button)
  // ----------------------------------------------------------------
  // This wipes the RAM so if they leave without saving, data is lost.
  void clearCurrentSession() {
    _collected.clear();
    notifyListeners();
  }
}