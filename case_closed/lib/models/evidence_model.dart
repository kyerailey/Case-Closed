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
  final List<Evidence> _collected = [];
  bool _hasSaveFile = false; // Tracks if the user has saved before

  List<Evidence> get collected => _collected;
  bool get hasSaveFile => _hasSaveFile;

  // Add evidence to the list (Memory only)
  void addEvidence(Evidence evidence) {
    if (!_collected.any((e) => e.id == evidence.id)) {
      _collected.add(evidence);
      notifyListeners();
    }
  }

  // ------------------------------------------------
  // SAVE / LOAD LOGIC
  // ------------------------------------------------

  // 1. SAVE: Writes the list of Evidence IDs to phone storage
  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert our list of Evidence objects into a list of Strings (IDs)
    final List<String> evidenceIds = _collected.map((e) => e.id).toList();
    
    await prefs.setStringList('death_row_evidence', evidenceIds);
    await prefs.setBool('death_row_saved', true); // Mark that a save exists
    
    _hasSaveFile = true;
    notifyListeners();
  }

  // 2. LOAD: Reads the IDs and rebuilds the list
  // We will call this when the app starts
  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Check if a save exists
    _hasSaveFile = prefs.getBool('death_row_saved') ?? false;

    if (_hasSaveFile) {
      final List<String>? savedIds = prefs.getStringList('death_row_evidence');
      
      if (savedIds != null) {
        _collected.clear();
        // We have to reconstruct the Evidence objects based on IDs.
        // In a real app, you might have a master list of all evidence to look up details.
        // For now, we will assume we know the details based on the ID.
        for (String id in savedIds) {
          if (id == 'red_cup') {
            _collected.add(Evidence(id: 'red_cup', title: 'Red Solo Cup', description: 'Residue found.'));
          } else if (id == 'necklace') {
             _collected.add(Evidence(id: 'necklace', title: 'Broken Necklace', description: 'Snapped chain.'));
          }
          // Add other IDs here as you create more clues
        }
        notifyListeners();
      }
    }
  }
}