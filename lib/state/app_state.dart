import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String selectedMood = 'Cozy';

  void updateMood(String mood) {
    selectedMood = mood;
    notifyListeners();
  }
}