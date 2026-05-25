import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/design_project.dart';
import '../state/favorites_state.dart';
import '../utils/app_theme.dart';

class ProjectCard extends StatelessWidget {
  final DesignProject project;
  final VoidCallback onTap;
  final VoidCallback? onCompare;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.onCompare,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesState = Provider.of<FavoritesState>(context);
    final isFavorite = favoritesState.isFavorite(project.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    project.imageUrl,
                    height: 205,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: _tag(project.mood),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.55),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          favoritesState.toggleFavorite(project);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${project.roomType} • ${project.style} • ${project.budgetLevel}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.valueAdded,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: project.skills.take(3).map((skill) {
                      return Chip(
                        label: Text(
                          skill,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: AppTheme.cream,
                        side: BorderSide.none,
                      );
                    }).toList(),
                  ),
                  if (onCompare != null) ...[
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: onCompare,
                      icon: const Icon(Icons.compare_arrows),
                      label: const Text('Compare'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}