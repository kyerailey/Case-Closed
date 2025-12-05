import 'package:flutter/material.dart';

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

  List<Evidence> get collected => _collected;

  void addEvidence(Evidence evidence) {
    if (!_collected.any((e) => e.id == evidence.id)) {
      _collected.add(evidence);
      notifyListeners();
    }
  }
}
