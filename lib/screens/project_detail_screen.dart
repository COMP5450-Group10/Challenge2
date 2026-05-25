import 'package:flutter/material.dart';
import '../models/design_project.dart';
import '../utils/app_theme.dart';
import 'contact_screen.dart';

class ProjectDetailScreen extends StatelessWidget {
  final DesignProject project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  Widget section(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.darkBrown,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget chipSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.darkBrown,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Chip(
                label: Text(item),
                backgroundColor: AppTheme.cream,
                side: BorderSide.none,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final summary =
        'Interested project: ${project.title}\nRoom: ${project.roomType}\nMood: ${project.mood}\nStyle: ${project.style}';

    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: Text(project.title),
      ),
      body: ListView(
        children: [
          Image.asset(
            project.imageUrl,
            width: double.infinity,
            height: 280,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${project.roomType} • ${project.mood} • ${project.style} • ${project.budgetLevel}',
                ),
                const SizedBox(height: 24),

                section('Design Challenge', project.challenge),
                section('Design Solution', project.solution),
                section('Value Added', project.valueAdded),
                section('Before', project.beforeDescription),
                section('After', project.afterDescription),

                chipSection('Skills Demonstrated', project.skills),
                chipSection('Materials', project.materials),
                chipSection('Color Palette', project.colorPalette),
                chipSection('Related Services', project.relatedServices),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.mail_outline),
                    label: const Text('Request Similar Design'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ContactScreen(
                            selectedInterest: summary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}