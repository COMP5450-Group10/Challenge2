import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/favorites_state.dart';
import '../widgets/project_card.dart';
import 'project_detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesState = Provider.of<FavoritesState>(context);
    final favorites = favoritesState.favorites;

    if (favorites.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(28),
          child: Text(
            'No saved projects yet.\nTap the heart icon on project cards to save design inspirations.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Saved Inspirations',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 18),
        ...favorites.map((project) {
          return ProjectCard(
            project: project,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProjectDetailScreen(project: project),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}