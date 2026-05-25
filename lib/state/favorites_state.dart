import 'package:flutter/material.dart';
import '../models/design_project.dart';

class FavoritesState extends ChangeNotifier {
  final List<DesignProject> _favorites = [];

  List<DesignProject> get favorites => _favorites;

  bool isFavorite(String projectId) {
    return _favorites.any((project) => project.id == projectId);
  }

  void toggleFavorite(DesignProject project) {
    if (isFavorite(project.id)) {
      _favorites.removeWhere((item) => item.id == project.id);
    } else {
      _favorites.add(project);
    }

    notifyListeners();
  }
}